Return-Path: <stable+bounces-114290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6BA2CC85
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460751886C92
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A971A3142;
	Fri,  7 Feb 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXa/pPS0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D119D072;
	Fri,  7 Feb 2025 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956388; cv=none; b=lRTZNeGXwzm6k1ymBBYkkDmCqtla1DPAJs0q2se7mcL+8iSlot5ObY4vtj6bJSf/Jd6hpCdCqwv3VjQGCirEcKygf9UVO7Ag4oqa31wjFcXzLt7YWdgHXE+LtAZ4RkY+9toktlx8MfMGrzG4iRSdN5BtU0aTH2tw4WjybzjKY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956388; c=relaxed/simple;
	bh=lNXYtgRntZTQf1TwUd0H3zh30GCjJO1ZmaWPP8yDtjw=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=Kt7V6xvrncUHKIWVk0u01zyvrrqY2v4or1brdnyKd7Gwf++jIrV8RR3azun1ijp7mBYu8E8plhbMk9kcVmbPeQ58dynxf/w60PRwU5WJn6Q+y72ahYc9GWgL9aSWYXyqVy79+tFWbPW871FnG1kj2F4SJMn6+X5ZYvUAjCwcVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXa/pPS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F031EC4CED1;
	Fri,  7 Feb 2025 19:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956388;
	bh=lNXYtgRntZTQf1TwUd0H3zh30GCjJO1ZmaWPP8yDtjw=;
	h=Date:Subject:From:To:Cc:From;
	b=QXa/pPS0Dl5sLKmxjUcOHVoYEpWkLQy6V7PGxf0hM733+lZhQFO8kFbN9pPW4bQt/
	 YgO9AiFQkYGgCjSCOxlogUupyjPtSZpVXtXxN579EVejg1eL4tcSOirL3AUz6sfJa2
	 Z6rbFlrZoh8D9jHCSAopVHn0Rv69nLZErlicHgCFJHewROjNYoyzkoIIh7fSoy1rJu
	 dtUBUwpLlE9y4xICA9TPJe5oFFtz6stCrYD0rCNaxYpkhdgZWsIpoKc2N9d7gid3+M
	 ujryLg+PsigANet21fXvfvfMfnHCmoGSsbtclDuy1sm/vVQNBlmewqVpeDKACK42EQ
	 AJnuQzbORwWHA==
Date: Fri, 07 Feb 2025 11:26:27 -0800
Subject: [PATCHSET 6.12] xfs: bug fixes from 6.13
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: hch@lst.de, eflorac@intellique.com, stable@vger.kernel.org,
 syzbot+3126ab3db03db42e7a31@syzkaller.appspotmail.com, cem@kernel.org,
 leo.lilong@huawei.com, stable@vger.kernel.org
Message-ID: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a bunch of hand-ported bug fixes for 6.12 LTS.  Most of the
patches fix a warning about dquot reclaim needing to read dquot buffers
in from disk by pinning buffers at transaction commit time instead of
during reclaim.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=next-6.12.y
---
Commits in this patchset:
 * xfs: avoid nested calls to __xfs_trans_commit
 * xfs: don't lose solo superblock counter update transactions
 * xfs: don't lose solo dquot update transactions
 * xfs: separate dquot buffer reads from xfs_dqflush
 * xfs: clean up log item accesses in xfs_qm_dqflush{,_done}
 * xfs: attach dquot buffer to dquot log item buffer
 * xfs: convert quotacheck to attach dquot buffers
 * xfs: don't over-report free space or inodes in statvfs
 * xfs: release the dquot buf outside of qli_lock
 * xfs: lock dquot buffer before detaching dquot from b_li_list
 * xfs: fix mount hang during primary superblock recovery failure
---
 fs/xfs/xfs_dquot.h            |    6 +
 fs/xfs/xfs_dquot_item.h       |    7 +
 fs/xfs/xfs_quota.h            |    7 +
 fs/xfs/xfs_buf_item_recover.c |   11 ++
 fs/xfs/xfs_dquot.c            |  199 +++++++++++++++++++++++++++++++++++------
 fs/xfs/xfs_dquot_item.c       |   51 ++++++++---
 fs/xfs/xfs_qm.c               |   48 ++++++++--
 fs/xfs/xfs_qm_bhv.c           |   27 ++++--
 fs/xfs/xfs_trans.c            |   39 ++++----
 fs/xfs/xfs_trans_ail.c        |    2 
 fs/xfs/xfs_trans_dquot.c      |   31 +++++-
 11 files changed, 338 insertions(+), 90 deletions(-)


