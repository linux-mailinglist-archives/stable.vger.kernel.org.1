Return-Path: <stable+bounces-239250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMFsEcta5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:56:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B043040A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C12C35F5EF9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6323264E7;
	Mon, 20 Apr 2026 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nW9AqlPH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpynHaoY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nW9AqlPH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpynHaoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7632572F
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696899; cv=none; b=f6rh4EmC6B9lL/tc37k6Vh6FBkruYwn2yk0+Dxt5Uht60jXzRJPn4wWbUDrbb3b82zLPPjYof592Meb3JghaOL7isIIfdwgE/B1LemqbRhn1xBzw1GRu+4ZjpuBKXWVTghoLmBObenFZA5QBI7BMo9lxzJLa9enT/bddTmKBzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696899; c=relaxed/simple;
	bh=D1QE16rDBt4NAUVqtT+ZWNWMBgWZ1R45s4mPHFKMGIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEDpTmBSMqU5COvmcS8X5cfQiJHEn4dC+2LQRdHtwrQ9pHLKdGwogRZsXqukANM6k/PamIQh2JZzpjN4+92I9N2KxOADpChR/iJG1mkxHn/O7L018bMz1O/bSPBkzszzS9wYyLjbx40WP0/S+F4/64oECBHeQ1CPfDDvodyYux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nW9AqlPH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bpynHaoY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nW9AqlPH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bpynHaoY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FD026A7D9;
	Mon, 20 Apr 2026 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776696896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWdL3AcjczyW6Ufen4oOCQ0zENqs0W41JnxYYCcU5VY=;
	b=nW9AqlPH4MldIICM+2Q66ijCVMgQSRYeP4CWhUxYzeuRlvkzdt5jVXLML6awsWyuZnG2mS
	9lomJxB1ugyAFfI/vMhS/YqnRw8/9kYVSetRNXll5hXky4/t9tmu6GTypvgF+GerbOoRPx
	o+cFv4eFCIRtjn5V9RBdEWiP/++OJA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776696896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWdL3AcjczyW6Ufen4oOCQ0zENqs0W41JnxYYCcU5VY=;
	b=bpynHaoY//eECMogEaPEt2TZjW+LgiuONfDCLX5BPC8zWiu3W8DdShBPCEqLIaYzB8OOe+
	F1L5lH2rxP2hnHBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nW9AqlPH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bpynHaoY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776696896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWdL3AcjczyW6Ufen4oOCQ0zENqs0W41JnxYYCcU5VY=;
	b=nW9AqlPH4MldIICM+2Q66ijCVMgQSRYeP4CWhUxYzeuRlvkzdt5jVXLML6awsWyuZnG2mS
	9lomJxB1ugyAFfI/vMhS/YqnRw8/9kYVSetRNXll5hXky4/t9tmu6GTypvgF+GerbOoRPx
	o+cFv4eFCIRtjn5V9RBdEWiP/++OJA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776696896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWdL3AcjczyW6Ufen4oOCQ0zENqs0W41JnxYYCcU5VY=;
	b=bpynHaoY//eECMogEaPEt2TZjW+LgiuONfDCLX5BPC8zWiu3W8DdShBPCEqLIaYzB8OOe+
	F1L5lH2rxP2hnHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 760E9593AE;
	Mon, 20 Apr 2026 14:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uA7JHEA+5mlGBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 14:54:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32711A0913; Mon, 20 Apr 2026 16:54:56 +0200 (CEST)
Date: Mon, 20 Apr 2026 16:54:56 +0200
From: Jan Kara <jack@suse.cz>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Edward Adam Davis <eadavis@qq.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] isofs: hardening for crafted CE and NFS-handle paths
Message-ID: <67ipkpvii4qgfp6vj4qqspned4fbtnmy2iv72m4rz4i2v7rgsy@qkrnzclryp3s>
References: <20260419212155.2169382-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419212155.2169382-1-michael.bommarito@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239250-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.cz,qq.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9A1B043040A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun 19-04-26 17:21:53, Michael Bommarito wrote:
> Two small defensive bounds checks for the ISO 9660 filesystem, one
> in Rock Ridge CE continuation handling and one in the NFS export
> path.  Both surfaced while looking for missing bounds checks
> adjacent to recently-landed isofs fixes (0405d4b63d08,
> f54e18f1b831).  Neither is a memory-safety bug on its own; the
> existing sb_bread() / isofs_iget() paths handle out-of-range
> blocks cleanly.  These patches reject the malformed input at the
> earliest point it is known to be out of range.
> 
> 1/2: rock_continue() reads rs->cont_extent from the Rock Ridge CE
> record and calls sb_bread() on it without validating the block number
> against ISOFS_SB(sb)->s_nzones.  commit e595447e177b (2005) added the
> cont_offset and cont_size rejection but left the extent number
> unchecked; commit f54e18f1b831 ("isofs: Fix infinite looping over CE
> entries") later capped the CE chain at RR_MAX_CE_ENTRIES = 32 but
> again did not address the block number.  The reachable attacker model
> is a crafted ISO auto-mounted via udisks2 / polkit on a desktop
> session; sb_bread() on an out-of-range block returns NULL cleanly, so
> there is no memory-safety issue, and the CE buffer is parsed as Rock
> Ridge records rather than returned verbatim via readlink().
> 
> 2/2: isofs_fh_to_dentry() and isofs_fh_to_parent() pass
> attacker-controlled block numbers from the NFS file handle to
> isofs_export_iget(), which rejects block == 0 but not out-of-range
> block numbers.  commit 0405d4b63d08 ("isofs: Prevent the use of too
> small fid", CVE-2025-37780) added fh_len checks but left the block
> number itself unchecked.  An authenticated NFS peer with a crafted
> fid can drive reads of adjacent-partition data on the same block
> device into iso_inode_info fields reaching the client as dentry
> metadata.  Deployment surface is narrow (isofs-over-NFS); impact is
> primarily EIO / ESTALE with a weak info-leak channel.
> 
> Both patches are one-line (or close to it) additions; the existing
> out-of-range-block check in isofs_iget() / sb_bread() handles the
> read-side cleanly, so these are strictly belt-and-suspenders
> rejection at the earliest point we know the input is out of range.
> 
> Build-tested W=1 against 7.0-rc7 with CONFIG_ISO9660_FS=y,
> CONFIG_JOLIET=y, CONFIG_ZISOFS=y.

Thanks! I've picked both fixes into my tree.

								Honza

> 
> Michael Bommarito (2):
>   isofs: validate Rock Ridge CE continuation extent against volume size
>   isofs: validate block number from NFS file handle in isofs_export_iget
> 
>  fs/isofs/export.c | 2 +-
>  fs/isofs/rock.c   | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

