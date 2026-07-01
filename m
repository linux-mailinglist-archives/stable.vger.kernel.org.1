Return-Path: <stable+bounces-270169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FxjCHy8XRWpQ6woAu9opvQ
	(envelope-from <stable+bounces-270169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 15:33:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A46EE2B5
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 15:33:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QBkIcOoi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270169-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270169-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6803A3020ECF
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B8481659;
	Wed,  1 Jul 2026 13:28:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10CE1A275;
	Wed,  1 Jul 2026 13:28:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912485; cv=none; b=bM8VbOVqzJCOElfebLPsBKvRf6t+0W9Q+MjfFdNmxrP/kBMcVsjnvaVML4biZ2dGjfiWqUmWoKS7a4dZpboBYVvfDXymUidQxKF26qUA1Fo6b/c3RMGWHYXdrgS75d5IOeHWsuYILarL3zagv0gx2N5sKKKPrC99B5fXfYwnoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912485; c=relaxed/simple;
	bh=iKscDZQfy0MtN4T97LK36aJevrKA4UAXQeqiSYbMIyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mriY/hXyIuc+k6nE+gG/NmqbVQJO4C0wfVSAGBTK44UPRXC74RuqQVQ/casTKjpb7L0rHFK/iHtW1F5wHP92NCeWAcTdws6Jz+BEu+r/YX3tDYqPbPEHXkZcVmZ7CvUL3E3h21YipxmHYLaffliz/wcQI6Pd6QzZudac11atzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBkIcOoi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE62B1F000E9;
	Wed,  1 Jul 2026 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782912484;
	bh=S/ir4WC1F7FyETK8VqjWLb5Y+h//+o4RHG1aeGMPGPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBkIcOoiSZQuYYK7QffAwCNm8VaK++eXTg9AS9VzPGwSsZmNe721QfD5tLz0b5Ljb
	 ERybIPZ7UuKg70udSUh9Q7eOo7zB8AJYJB13RW0B0gKO+zjDFlqE1pfKCrU+V6INxn
	 TlEjtN0MBdNs7Feqv9TDr/7CiYC0dt+iiVMhTx+dNJQMW8Ld8IphDTJDZjDp7Umn5F
	 M2rvGjzuDP/DBJUpfAARQoQ8IeDuScYB4VkDJwESKSuVGxquOomHKsPgr+z5851UJb
	 FNRZI4ms/t9yiUs2jrV1bdlAXEQSYynE3g4laKriuldFn2wUzcnPKXLr3Prazk95Xv
	 ZeHqosXQ2hpXQ==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Kelu Ye <yekelu1@huawei.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iomap: consolidate bio submission
Date: Wed,  1 Jul 2026 15:27:40 +0200
Message-ID: <20260701-davon-kniegelenk-gedehnt-96476b242a09@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629121750.3392300-2-hch@lst.de>
References: <20260629121750.3392300-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=brauner@kernel.org; h=from:subject:message-id; bh=iKscDZQfy0MtN4T97LK36aJevrKA4UAXQeqiSYbMIyY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5it7RsWDc2sutssqLV0pi/oIv7G6tQj4SdWfS564sN 1S5YvS9o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK3IhgZXn05sNjoiK6LmpzZ kcUpV9dIfso4M2nzmZJgzb9SPNb6lgz/9Pi6PGc+u+HOtq8gTdxvdnHqPs1ItmXMtw7+cZHdLbG KGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270169-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E12A46EE2B5

On Mon, 29 Jun 2026 14:17:38 +0200, Christoph Hellwig wrote:
> Add a iomap_bio_submit_read_endio helper factored out of
> iomap_bio_submit_read to that all ->submit_read implementations for
> iomap_read_ops that use iomap_bio_read_folio_range can shared the
> logic.
> 
> Right now that logic is mostly trivial, but already has a bug for XFS
> because the XFS version is too trivial:  file system integrity validation
> needs a workqueue context and thus can't happen from the default iomap
> bi_end_io I/O handler.  Unfortunately the iomap refactoring just before
> fs integrity landed moved code around here and the call go misplaced,
> meaning it never got called.  The PI information still is verified by
> the block layer, but the offloading is less efficient (and the future
> userspace interface can't get at it).
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

[1/3] iomap: consolidate bio submission
      https://git.kernel.org/vfs/vfs/c/044472d5ee7d
[2/3] fuse: call fuse_send_readpages explicitly from fuse_readahead
      https://git.kernel.org/vfs/vfs/c/3372eb0384b7
[3/3] iomap: submit read bio after each extent
      https://git.kernel.org/vfs/vfs/c/c1fb97d31782

