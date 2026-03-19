Return-Path: <stable+bounces-227204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC70AmZmu2lVjgIAu9opvQ
	(envelope-from <stable+bounces-227204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:58:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE3D2C53A1
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E52230A04DF
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 02:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615A3876B2;
	Thu, 19 Mar 2026 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC6VFDql"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0511A9F97;
	Thu, 19 Mar 2026 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889093; cv=none; b=Tq2lH+HikB1zrxUt1zDGEPvE3YnTJrFFxIHC/YMWYmIMou8ODJH5uvhX9hZjI4yxaxxNv4m8fqe6Ji+wtcTml1FAFlhmTje87IPzzGIOmn16hfTXRCT7TjMubir05PqSznlhBUU2Fx0A+YJJO+eG6Z8OEV7ZRD+1duEhyIriBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889093; c=relaxed/simple;
	bh=DD776qvrhptS/c7ZpCzpmp7GE9bv7ai0gPDAUetaFGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2ATBnbLtxpeyAfPbnexbVUyDriVaP7NcxQoG7p9Go0sDguIDqVSpsbaptYfUYH1bJCVHTSyh6bKRFE4QlEU20ZYrmi93ATAMkur3Oh8qGOgpJt9QvEzhof0bKxmrdJoRdx2KmoAbUgV2pq1Kw1ij05Zg+Gp7bQIFQcwr3uNwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC6VFDql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C89C2BCAF;
	Thu, 19 Mar 2026 02:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773889093;
	bh=DD776qvrhptS/c7ZpCzpmp7GE9bv7ai0gPDAUetaFGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BC6VFDqlL6b7/0amaL5oGAFRPP3oJLpv4GENFaEB4Fyt9jcOPVyQSd9vJnktoL+te
	 7B4Z6SOT/JhqE8pozRwZ4Plcly1bmCHCqooT8OD1i/JR9fhmABcGM3RPJhz+PQu+PC
	 5tBJLxSZq1bmh9nnsoOJSh5TVtXrW7voZOrzIupQrdOg7cS8XHBB/0ki00VEDsNdGE
	 Raka3+PRDqSW3y7a12eCtvXF5K95u9aftfcJzrGl+rB1XlnKcdVsRizAucftp3grb4
	 DlQbXBjsre11VvKAJE0+Us02MsTz4NkumfCUt7WKNwldhkAyhwuHI9e+6oJlsV5E5G
	 wF9VKxOoP/Mnw==
Date: Wed, 18 Mar 2026 19:57:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, baijiaju1990@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: annotate data races around fi->i_flags
Message-ID: <20260319025710.GA357817@sol>
References: <20260319022335.3213311-1-zzzccc427@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319022335.3213311-1-zzzccc427@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227204-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.sourceforge.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FE3D2C53A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:23:35AM +0800, Cen Zhang wrote:
> fi->i_flags can be read by f2fs_update_inode() in the writeback path,
> f2fs_getattr(), and f2fs_fileattr_get() without holding inode_lock or
> fi->i_sem, while it can be concurrently written by
> f2fs_setflags_common(), set_compress_context(), and
> f2fs_disable_compressed_file() under inode_lock and/or fi->i_sem.
> 
> This is a data race as defined by the LKMM.  Use READ_ONCE() on the
> read side and WRITE_ONCE() on the write side to ensure proper marking
> of the concurrent accesses.
> 
> Fixes: 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4 i_flags")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Is that really the correct Fixes commit?  I don't see what it has to do
with this issue.

- Eric

