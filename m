Return-Path: <stable+bounces-242093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA/FNQ9E82lDzAEAu9opvQ
	(envelope-from <stable+bounces-242093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:59:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 354F84A278D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B89B30182BD
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2723FA5CC;
	Thu, 30 Apr 2026 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="TFIUTwSU"
X-Original-To: stable@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B03AB294;
	Thu, 30 Apr 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550307; cv=none; b=tQRxE7lrfBEYsT0NF638RNgk2DGI56DVYIjMvIiJN2yV669I3Bu75nPutVnYh27o/um+iWQOseTe5Jc3Ln3SRy+568k75AQ6zKPFADi7stcckGWLTtrLp58a6t9rKgKSwJMygEOEh8zY9FxERVfCACw7pbkRHNDMTMlM0nO143o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550307; c=relaxed/simple;
	bh=3ERtXKUFHXuJ3le2SNtpi49sIu/Scqmldi0MxFG6JtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iGs7VJOVvD3B0IuoC886rFvODrqyKZTPcBBAzzBgkJ4YwkNyLDyb3w/7iEQuavwky62M2fdfP87Ul82YSWpfxsoAPkbRNn4VnEf7LDIs42q69MiyU2n2/IKcMb+A5FZDMhErbSYIrGvr4IMrkpoxRPToWbz7gDLgYeFuacU22vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=TFIUTwSU; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B623B1D47;
	Thu, 30 Apr 2026 11:58:25 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=TFIUTwSU;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id E215B2133;
	Thu, 30 Apr 2026 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1777550297;
	bh=b3m7VUHX6nz2dIH7u7IHU0RNpctq4AB0Qv+256/ZUPk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TFIUTwSUb1rgtNAp1N+r6T6kXoOgXFpHfN4V6oXUT1UjgrkTI5NS/ZPdDoWwxnc96
	 v5/COQC6QlF5ISQ09sggeTGJglePhwjpJ5Gbm1xVtHAgNJ8hjyDii/bFhIj5vipSDD
	 sOSmyfPywPvylCIFyzcKUaGkGV+fbvKnFXI9EQ7g=
Received: from [192.168.95.128] (172.30.20.214) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 30 Apr 2026 14:58:17 +0300
Message-ID: <e6ed6668-7251-4847-9511-ccad55c5f6d2@paragon-software.com>
Date: Thu, 30 Apr 2026 13:58:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: add depth limit to indx_find_buffer to prevent
 stack overflow
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260413133117.3687677-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260413133117.3687677-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Queue-Id: 354F84A278D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242093-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aka.ms:url,paragon-software.com:dkim,paragon-software.com:mid]

On 4/13/26 15:31, Michael Bommarito wrote:

> [You don't often get email from michael.bommarito@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> indx_find_buffer() recursively descends the B+ tree index with no depth
> limit.  A crafted NTFS image with circular index node references causes
> unbounded recursion, overflowing the kernel stack and panicking the
> system.
>
> This is reachable by mounting a malicious NTFS filesystem (e.g. from a
> USB drive via desktop automount) and deleting a file whose index entry
> triggers the rebalancing fallback path in indx_delete_entry().
>
> Add a depth parameter and bail out with -EINVAL when it reaches the
> fnd->nodes array bound, matching the constraint already enforced by
> fnd_push() in indx_find().
>
> The related function indx_find() was previously patched for a similar
> infinite-loop issue (commit 1732053c8a6b), but indx_find_buffer() was
> missed.
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Found during a broader arch/um/ and filesystem security audit.
> This is the same class of bug as the one fixed by commit
> 1732053c8a6b ("fs: ntfs3: check return value of indx_find to
> avoid infinite loop"), which added a depth limit to indx_find()
> but missed indx_find_buffer().
>
> Reproduced on UML (ARCH=um) with a crafted NTFS image containing
> a circular B+ tree directory index. Mounting the image and
> deleting a specific file triggers indx_delete_entry() ->
> indx_find_buffer() -> unbounded recursion -> stack overflow:
>
>    Kernel panic - not syncing: Kernel tried to access user memory
>      at addr 0x606128c4, ip 0x6012907e
>    Call Trace:
>     [<60611ec2>] ? indx_read_ra+0x0/0x677
>
> At 168+ bytes per frame, ~97 recursions overflow the 16KB kernel
> stack. Desktop automount (udisks2 + ntfs3) means a crafted USB
> drive can trigger this without privilege.
>
> Note: the pre-existing indx_node allocated by indx_read() during
> the DFS is leaked when the new depth limit fires. This is a
> pre-existing issue (the node was also leaked on any other error
> return from indx_find_buffer); fixing it cleanly requires
> restructuring the node ownership model and is left for a
> follow-up patch.
>
> Reproducer script and crafted image builder available on request.
>
>   fs/ntfs3/index.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 97f06c26fe1a..2c43e7c27861 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -2013,13 +2013,21 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>   static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
>                                            struct ntfs_inode *ni,
>                                            const struct INDEX_ROOT *root,
> -                                         __le64 vbn, struct indx_node *n)
> +                                         __le64 vbn, struct indx_node *n,
> +                                         int depth)
>   {
>          int err;
>          const struct NTFS_DE *e;
>          struct indx_node *r;
>          const struct INDEX_HDR *hdr = n ? &n->index->ihdr : &root->ihdr;
>
> +       /*
> +        * Limit recursion depth to prevent stack overflow from crafted
> +        * images.  Use the same bound as the fnd->nodes array (20).
> +        */
> +       if (depth > ARRAY_SIZE(((struct ntfs_fnd *)NULL)->nodes))
> +               return ERR_PTR(-EINVAL);
> +
>          /* Step 1: Scan one level. */
>          for (e = hdr_first_de(hdr);; e = hdr_next_de(hdr, e)) {
>                  if (!e)
> @@ -2040,7 +2048,8 @@ static struct indx_node *indx_find_buffer(struct ntfs_index *indx,
>                          if (err)
>                                  return ERR_PTR(err);
>
> -                       r = indx_find_buffer(indx, ni, root, vbn, n);
> +                       r = indx_find_buffer(indx, ni, root, vbn, n,
> +                                            depth + 1);
>                          if (r)
>                                  return r;
>                  }
> @@ -2446,7 +2455,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
>
>                  fnd_clear(fnd);
>
> -               in = indx_find_buffer(indx, ni, root, sub_vbn, NULL);
> +               in = indx_find_buffer(indx, ni, root, sub_vbn, NULL, 0);
>                  if (IS_ERR(in)) {
>                          err = PTR_ERR(in);
>                          goto out;
> --
> 2.53.0
>
Hello,

Sorry for the delay.
Your patch was applied, thanks.

Regards,
Konstantin


