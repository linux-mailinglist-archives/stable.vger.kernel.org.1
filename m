Return-Path: <stable+bounces-171763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C226CB2BFFD
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D6B17ACF1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7E322777;
	Tue, 19 Aug 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJJzaIiu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07C284887;
	Tue, 19 Aug 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601933; cv=none; b=mV0LxkwL2sIE+6Tih5OYZu77xyQ0YCf4okzGWngIGA/0kiDoDESbIfPgyCZly/5EZEbp5t3ej6rnlkyV9ghZA4NhBbd1BkUblJfQZP5avCm3UMLZOaDk4A2nEL06uliAvj5Dm9hgtQxtGFB/B2oAeO6lUGhMO1uttXBOCGCQN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601933; c=relaxed/simple;
	bh=1rgDR65KuPRTY0P6UJTUUd10kaG6YRghNT0SkPCCCdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmV/C6Kdo9rwIpJI4LjTXLUpJhSXkr1V9IOPcjca34XJTYD8hMk1tk+KTICMaKkL/8POVhN41hKyK1zfgQLEJ+FPf611Rx0R0ncy6iFsBIlgzrbObkjVwUi14rfnM8FVhzEDb5t09+qsnCj+Gakf/rsFBKYhiGqFjHYwM47qnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJJzaIiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8BEC4CEF1;
	Tue, 19 Aug 2025 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601933;
	bh=1rgDR65KuPRTY0P6UJTUUd10kaG6YRghNT0SkPCCCdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJJzaIiuaKGH9NIZDKgXuAU2NFX57JEQV36t9DdANRHEnRtieeTs3b2FQ0glF4q2w
	 cfmVtEcSZN3G06XyOznkkiz2jcQzs48I5AnpHnuLqJ/JreO45ABZYUlDmMDKL8h7bJ
	 A+QIpfeMywf91ckqUXxGUrN7efZyHlg575T+a1PFvnASPZM1tJYg5akTq9h6B05u+X
	 6eJdyAcd6Tfjq8XAAsoRsQlDldyPWdHHxM1ZFemxbcyozgP75ZOnySfOeaIPDRkzEB
	 7pCWbYrgA7coCW7xbjbyUxP9ATMsj1Gb+hTN5jZf2MldtC2xnKATzZxZSVLOgM+f4F
	 +arCxYiLx3y2A==
From: Christian Brauner <brauner@kernel.org>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH v3] debugfs: fix mount options not being applied
Date: Tue, 19 Aug 2025 13:11:58 +0200
Message-ID: <20250819-hotel-talent-c8de78760a68@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816-debugfs-mount-opts-v3-1-d271dad57b5b@posteo.net>
References: <20250816-debugfs-mount-opts-v3-1-d271dad57b5b@posteo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=brauner@kernel.org; h=from:subject:message-id; bh=1rgDR65KuPRTY0P6UJTUUd10kaG6YRghNT0SkPCCCdo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsiWF7ElcSNOvD6dQbqWtXTFjhNUHe/JpLdXuW8OFf1 +5cn945s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/BsYfrPoGDc3M+VqL/xS cfO8iAXPOYZkYa3775d++b15Q1LGnJcM/6N6GC8bRC/tdvtSb50sezRjxWwOgdDl3I/5xYLXfpd 8yA8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 16 Aug 2025 14:14:37 +0000, Charalampos Mitrodimas wrote:
> Mount options (uid, gid, mode) are silently ignored when debugfs is
> mounted. This is a regression introduced during the conversion to the
> new mount API.
> 
> When the mount API conversion was done, the parsed options were never
> applied to the superblock when it was reused. As a result, the mount
> options were ignored when debugfs was mounted.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] debugfs: fix mount options not being applied
      https://git.kernel.org/vfs/vfs/c/8e7e265d558e

