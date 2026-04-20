Return-Path: <stable+bounces-239237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHlvEHFZ5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2F430195
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBBC3555910
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A813D9DB7;
	Mon, 20 Apr 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vjil2/RS"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB33AC0ED;
	Mon, 20 Apr 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695502; cv=none; b=ldG8croggPkKtByVRnkbBo7Rz8VZRMDTnZgdCNbfeDI8eM0iFP12RAPRIhWHjf24nGGE4xz6oulL7mgufRA+AbsXmKa8LYHGgRjdNym2wKsg78y6oEr+Xi4cZSGRW8I308HJjEyZsbctFOHWJd9SBf6W/Zu4QqfxnYk0MXdl+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695502; c=relaxed/simple;
	bh=x+JqpWLPmdef5FaSoZXOfjYFpxRINfunce0VlJIENXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sblBAjSn3rrtvbiBkjaiJqOVnheDjl4rISbwsqqR1Ma3nV8iLgDJl9Ov62Q3TXyvyRIkpSm4j0j0cQGcgufTH86sIElejdcN9P1A0OiZqFEuLuUac6Hymz9zg9U7kNimoDInlLV/V9Y0LEZNshKF+iXlySlwzxMobFumnY6RN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vjil2/RS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H1wF9YisyBqnifw1s1SsCk/hmOi0Yw7A60SKrkB8C1s=; b=vjil2/RSRyNRQIpQdt2FsHBH5g
	d0ZcavK3y6ll2lHgkBygEt0IMAq4KdJUWwcvd39F4j46gtmJBepdXOyUC5PQjBzj2JrLAU1G2leoK
	jIE43wMzIpnAuJ1FcD2XQLD/sHem4eS9ah1UMAT8mvp+6R6bV7ndztm7GLyLaqEOxEptInsvIEEh4
	qRDgaEe1wMrSWydljQ6HovBlUXZE0TwhYeU8J0JJqgmPzpSXaggSsYv6tBPJ8Hwehc41oaW/e/hgV
	QQ+UtklCX8Q13WjFe/KD8Gz7o5ScpS+3zk6fTFSHCiUxfDsqnExcp+YerkY8Sbg3ZUcfaSD7Z2zDw
	7UtV029g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wEpeh-0009Gr-2o;
	Mon, 20 Apr 2026 14:31:20 +0000
Date: Mon, 20 Apr 2026 07:31:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eryu Guan <eguan@linux.alibaba.com>, 
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <aeY32gOaV5jw1s8F@gmail.com>
References: <20260126-9p-v1-1-dc234d53ae87@debian.org>
 <aZGRkaFZPXfZW8a0@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZGRkaFZPXfZW8a0@codewreck.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[debian.org];
	TAGGED_FROM(0.00)[bounces-239237-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codewreck.org:email]
X-Rspamd-Queue-Id: AAB2F430195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hello Dominique,

On Sun, Feb 15, 2026 at 06:27:45PM +0900, Dominique Martinet wrote:
> Thanks for the patch and sorry for the delay

I had this fix in my tree, and I had forgot about. Now that I moved to
the 7.1, I started seeing it again, so, let's revamp this.

> hmm.. I'm not actually sure if we should call drop_nlink() at all in
> cacheless mode, actually..
> We don't really care about nlink in this context, as inode should be
> gone immediately anyway, or does nlink hitting zero imply something
> else?
> 
> So we could get the v9fs_session_info out of the inode
> (v9fs_inode2v9ses) and just return if CACHE_META is set?

Agreed -- in cacheless mode the server is authoritative and the inode is
on its way out, so adjusting i_nlink locally buys us nothing. I don't
see anything else keying off nlink hitting zero in that path.

> Others opinion would be great, but I get the feeling that just checking
> before update only makes the race smaller, and not totally fixed.

What about sometehing like:

commit 369beed134ff0b7ce1cf68d0c46b08ec07d625db
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Jan 26 02:23:37 2026 -0800

    9p: skip nlink update in cacheless mode to fix WARN_ON
    
    v9fs_dec_count() unconditionally calls drop_nlink() on regular files,
    even when the inode's nlink is already zero. In cacheless mode the
    client refetches inode metadata from the server (the source of truth)
    on every operation, so by the time v9fs_remove() returns, the locally
    cached nlink may already reflect the post-unlink value:
    
      1. Client initiates unlink, server processes it and sets nlink to 0
      2. Client refetches inode metadata (nlink=0) before unlink returns
      3. Client's v9fs_remove() completes successfully
      4. Client calls v9fs_dec_count() which calls drop_nlink() on nlink=0
    
    This race is easily triggered under heavy unlink workloads, such as
    stress-ng's unlink stressor, producing the following warning:
    
      WARNING: fs/inode.c:417 at drop_nlink+0x4c/0xc8
      Call trace:
       drop_nlink+0x4c/0xc8
       v9fs_remove+0x1e0/0x250 [9p]
       v9fs_vfs_unlink+0x20/0x38 [9p]
       vfs_unlink+0x13c/0x258
       ...
    
    In cacheless mode the server is authoritative and the inode is on its
    way out, so locally adjusting nlink buys nothing. Skip v9fs_dec_count()
    entirely when neither CACHE_META nor CACHE_LOOSE is set, which both
    avoids the warning and removes a class of nlink races (two concurrent
    unlinkers observing nlink > 0 and both calling drop_nlink()) that an
    nlink == 0 guard alone would only narrow rather than close.
    
    Fixes: ac89b2ef9b55 ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
    Cc: stable@vger.kernel.org
    Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d1508b1fe1092..50cf837979d9c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -488,10 +488,19 @@ static int v9fs_at_to_dotl_flags(int flags)
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
+ * In cacheless mode the server is the source of truth for nlink and the
+ * inode is going away immediately, so locally adjusting i_nlink buys
+ * nothing and races with concurrent metadata fetches that may already
+ * have observed the post-unlink value (nlink == 0).
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
 {
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	if (!(v9ses->cache & (CACHE_META | CACHE_LOOSE)))
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }

