Return-Path: <stable+bounces-232803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCRQJDM/zWkkbAYAu9opvQ
	(envelope-from <stable+bounces-232803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 17:52:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A64AB37D7D5
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D76A31417C1
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E261A9FA4;
	Wed,  1 Apr 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="e8ax/MdY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611740DFCA
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057076; cv=none; b=cRJ8gZYHhzHFI5W0rpr8sO6tttJ3yyqRr0EB1K4QZEDY7KOUXtD+ZaEqVs6AP2I74sDs6CLpznwGo9ug00F9bFr1D9Oa2UIKKfKuV93JLy4s0jCAzUFytf4TEXwCVJpRZw4ejT9PQHRowzDgboyK3XwcJxg7XUdewNAAkePucnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057076; c=relaxed/simple;
	bh=cdD+wgRuXjA39RwUQeo/4YDq0oqGkXYeG7Ej6/FuoyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prM2Sq123/p6Q7zCUD+tht+dXmdRUIegU65rwusr7hJiBSlxKnGJ3cIlTdTkHJvIEWztEts9LVPPToABLIhVtJ2w8UTvyBYcEt9aEsJY3d0kiM451xufGgJDeuf8nlgLxmGb1UYVRSWNHioGg2I7VLHIWQVGTb6RFsiy3FNoerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=e8ax/MdY; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fm80m2KyGzLJd;
	Wed,  1 Apr 2026 17:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775057064;
	bh=e5MNM0KUrcE5binQPopBDgEVbpfbHrjOv+qqhnLbFRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8ax/MdYGOL4QyzxMzO3lCvQj4Egx8f6K9s6pcqZeEHLuHU/SvQlAATHsKU3dzun6
	 FB2rCMpcZ8Ez8UeMoAcpcR7Fwuu62NGIjNjblJ5k5zprSk+pRnfkgHoYFgfSCIcgoy
	 aGZv6F2MHLVeewBGWw+k8SWbx/uroOROAE8p7haw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fm80l51CgzXjB;
	Wed,  1 Apr 2026 17:24:23 +0200 (CEST)
Date: Wed, 1 Apr 2026 17:24:19 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Tingmao Wang <m@maowtm.org>, 
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH 6.12.y 2/9] landlock: Fix handling of disconnected
 directories
Message-ID: <20260401.Ahd4leZ5Dix3@digikod.net>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
 <20260324140456.832964-3-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324140456.832964-3-harshit.m.mogalapalli@oracle.com>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.99 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232803-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[digikod.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: A64AB37D7D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Harshit.  BTW, the following commit should also be backported
(and it was specifically created to ease backports): 6803b6ebb816
("landlock: Fix cosmetic change").

The current patch should be backported down to 5.15, but it needs to be
adapted.  Harshit, I can work on it, please let me know.

I'm wondering why I didn't get notified that some Fixes patch couldn't
automatically be backported.  Greg, is there some way to register for
this kind of issue?  What are the rules to not automatically backport
patches?

I also noticed that other Fixes commits were not backported to stable
branches whereas they can be cleanly cherry-picked.  I'm also wondering
why they weren't pick.

FYI, here are the ones that can be backported without needing changes:
- 602acfb54119 ("landlock: Optimize stack usage when !CONFIG_AUDIT")
- 60207df2ebf3 ("landlock: Remove useless include")
- 7aa593d8fb64 ("selftests/landlock: Fix missing semicolon")

They should all be backported, even if they look like cosmetic fixes
(because they might be needed for other fixes/backports).

Here is the other one that needs to be adapted:
- e4d82cbce225 ("landlock: Fix TCP handling of short AF_UNSPEC addresses")

Thanks,
 Mickaël

On Tue, Mar 24, 2026 at 07:04:49AM -0700, Harshit Mogalapalli wrote:
> From: Mickaël Salaün <mic@digikod.net>
> 
> [ Upstream commit 49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1 ]
> 
> Disconnected files or directories can appear when they are visible and
> opened from a bind mount, but have been renamed or moved from the source
> of the bind mount in a way that makes them inaccessible from the mount
> point (i.e. out of scope).
> 
> Previously, access rights tied to files or directories opened through a
> disconnected directory were collected by walking the related hierarchy
> down to the root of the filesystem, without taking into account the
> mount point because it couldn't be found. This could lead to
> inconsistent access results, potential access right widening, and
> hard-to-debug renames, especially since such paths cannot be printed.
> 
> For a sandboxed task to create a disconnected directory, it needs to
> have write access (i.e. FS_MAKE_REG, FS_REMOVE_FILE, and FS_REFER) to
> the underlying source of the bind mount, and read access to the related
> mount point.   Because a sandboxed task cannot acquire more access
> rights than those defined by its Landlock domain, this could lead to
> inconsistent access rights due to missing permissions that should be
> inherited from the mount point hierarchy, while inheriting permissions
> from the filesystem hierarchy hidden by this mount point instead.
> 
> Landlock now handles files and directories opened from disconnected
> directories by taking into account the filesystem hierarchy when the
> mount point is not found in the hierarchy walk, and also always taking
> into account the mount point from which these disconnected directories
> were opened.  This ensures that a rename is not allowed if it would
> widen access rights [1].
> 
> The rationale is that, even if disconnected hierarchies might not be
> visible or accessible to a sandboxed task, relying on the collected
> access rights from them improves the guarantee that access rights will
> not be widened during a rename because of the access right comparison
> between the source and the destination (see LANDLOCK_ACCESS_FS_REFER).
> It may look like this would grant more access on disconnected files and
> directories, but the security policies are always enforced for all the
> evaluated hierarchies.  This new behavior should be less surprising to
> users and safer from an access control perspective.
> 
> Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
> fix the related comment.
> 
> Because opened files have their access rights stored in the related file
> security properties, there is no impact for disconnected or unlinked
> files.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Song Liu <song@kernel.org>
> Reported-by: Tingmao Wang <m@maowtm.org>
> Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
> Closes: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Link: https://lore.kernel.org/r/b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org [1]
> Reviewed-by: Tingmao Wang <m@maowtm.org>
> Link: https://lore.kernel.org/r/20251128172200.760753-2-mic@digikod.net
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> (cherry picked from commit 49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1)
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  security/landlock/errata/abi-1.h | 16 +++++++++++++
>  security/landlock/fs.c           | 40 ++++++++++++++++++++++----------
>  2 files changed, 44 insertions(+), 12 deletions(-)
>  create mode 100644 security/landlock/errata/abi-1.h
> 
> diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
> new file mode 100644
> index 000000000000..e8a2bff2e5b6
> --- /dev/null
> +++ b/security/landlock/errata/abi-1.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/**
> + * DOC: erratum_3
> + *
> + * Erratum 3: Disconnected directory handling
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * This fix addresses an issue with disconnected directories that occur when a
> + * directory is moved outside the scope of a bind mount.  The change ensures
> + * that evaluated access rights include both those from the disconnected file
> + * hierarchy down to its filesystem root and those from the related mount point
> + * hierarchy.  This prevents access right widening through rename or link
> + * actions.
> + */
> +LANDLOCK_ERRATUM(3)
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index f0e94cb74fca..a26199568db2 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -899,21 +899,31 @@ static bool is_access_to_paths_allowed(
>  				break;
>  			}
>  		}
> +
>  		if (unlikely(IS_ROOT(walker_path.dentry))) {
> -			/*
> -			 * Stops at disconnected root directories.  Only allows
> -			 * access to internal filesystems (e.g. nsfs, which is
> -			 * reachable through /proc/<pid>/ns/<namespace>).
> -			 */
> -			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
> +			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
> +				/*
> +				 * Stops and allows access when reaching disconnected root
> +				 * directories that are part of internal filesystems (e.g. nsfs,
> +				 * which is reachable through /proc/<pid>/ns/<namespace>).
> +				 */
>  				allowed_parent1 = true;
>  				allowed_parent2 = true;
> +				break;
>  			}
> -			break;
> +
> +			/*
> +			 * We reached a disconnected root directory from a bind mount.
> +			 * Let's continue the walk with the mount point we missed.
> +			 */
> +			dput(walker_path.dentry);
> +			walker_path.dentry = walker_path.mnt->mnt_root;
> +			dget(walker_path.dentry);
> +		} else {
> +			parent_dentry = dget_parent(walker_path.dentry);
> +			dput(walker_path.dentry);
> +			walker_path.dentry = parent_dentry;
>  		}
> -		parent_dentry = dget_parent(walker_path.dentry);
> -		dput(walker_path.dentry);
> -		walker_path.dentry = parent_dentry;
>  	}
>  	path_put(&walker_path);
>  
> @@ -990,6 +1000,9 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>   * file.  While walking from @dir to @mnt_root, we record all the domain's
>   * allowed accesses in @layer_masks_dom.
>   *
> + * Because of disconnected directories, this walk may not reach @mnt_dir.  In
> + * this case, the walk will continue to @mnt_dir after this call.
> + *
>   * This is similar to is_access_to_paths_allowed() but much simpler because it
>   * only handles walking on the same mount point and only checks one set of
>   * accesses.
> @@ -1031,8 +1044,11 @@ static bool collect_domain_accesses(
>  			break;
>  		}
>  
> -		/* We should not reach a root other than @mnt_root. */
> -		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
> +		/*
> +		 * Stops at the mount point or the filesystem root for a disconnected
> +		 * directory.
> +		 */
> +		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
>  			break;
>  
>  		parent_dentry = dget_parent(dir);
> -- 
> 2.50.1
> 

