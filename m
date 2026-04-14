Return-Path: <stable+bounces-237774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJgnHBsS3mkomwkAu9opvQ
	(envelope-from <stable+bounces-237774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:08:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E03F86E5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B55130209FB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B63B4EBD;
	Tue, 14 Apr 2026 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ12I0Fk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858153A0E80;
	Tue, 14 Apr 2026 10:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160954; cv=none; b=eh89VG/dK7c+kgJk9Dqd0CwksCLXMSpnafgvvK4zPYnjLF2SZcHe93gJ7opyx+NVQ+3K/BONO3U0S8mlUwYz5Udu9Z2riKAAR7MUavytxk1/gehYKW8d1dYXYLaWAvWJ7SQIQ/8H0OFrgcTFTBi0aGyOJXp7UU6+mWxqV7xcJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160954; c=relaxed/simple;
	bh=xAHjUkDL9XAwkFdw2OYknLlMPiP/ljdQtVtGA4rFIC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mx7nHJ9Yuk1Kv1c4erPQDla8bG335kIACm7eCsY64kXcthdPHObcCjzX5Z1RQ2H0LjUR6emqRVfOtWw/6osEqucYOUGIwRSwxnxxZWQRTobt1VbmiyJYdTcUBvcZXwX8tWEn/BUby61FkDzeLUiHCCXoYabrfekWd5JLePmMAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ12I0Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE2C19425;
	Tue, 14 Apr 2026 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776160954;
	bh=xAHjUkDL9XAwkFdw2OYknLlMPiP/ljdQtVtGA4rFIC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJ12I0FkuvwW2jhgvN7h1laGM0acCOaSZbc6+DJdfeUamx5EJL3vsurAwvt0awDq1
	 QqnMMThJBdcOo477BS3Cx0lBxEWqwWo0Mt26GbmWQqxe+wDFNkG9YCXTIKrOiZQTzV
	 KpaXvXgKCG4ICG0EeRGw4k5lDbgGsMsx0j39Ld3wsmb04xDKkMEkW6SJCXWEi1XcGD
	 sdVrqtaETUYJkE4S0YOa/vg5Tovkp8Ei3IlzpIyEoD7BiNG8wb5C1ZNke+s3gEKHhU
	 q3oDouI68UwwQONU9tD+3Mk5dziH5nVWL0UTAOMDqbnfFcwl+ZR+pYR9Plz+29DWLm
	 RjXbd2cohpC9A==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] writeback: Fix use after free in inode_switch_wbs_work_fn()
Date: Tue, 14 Apr 2026 12:02:29 +0200
Message-ID: <20260414-pflug-rinnsal-6c9696b23507@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260413093618.17244-2-jack@suse.cz>
References: <20260413093618.17244-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=brauner@kernel.org; h=from:subject:message-id; bh=xAHjUkDL9XAwkFdw2OYknLlMPiP/ljdQtVtGA4rFIC8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTeE9haMDVBp0VyWq3PqeWXGLkiXYqOp/h/7VM6eujji 0vbJk+Q6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIlhCGv0I8z3ee/DVZjTVz 3TcjORfjZ2w/jkq6e4YeYFhgWaES+Y7hf/n0X/IS7GynmllTZ8+SOl9Rd2Jx7yRzPpXYuOQJLmU pDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237774-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C47E03F86E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 11:36:19 +0200, Jan Kara wrote:
> inode_switch_wbs_work_fn() has a loop like:
> 
>   wb_get(new_wb);
>   while (1) {
>     list = llist_del_all(&new_wb->switch_wbs_ctxs);
>     /* Nothing to do? */
>     if (!list)
>       break;
>     ... process the items ...
>   }
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] writeback: Fix use after free in inode_switch_wbs_work_fn()
      https://git.kernel.org/vfs/vfs/c/af423cdba49c

