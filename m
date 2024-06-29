Return-Path: <stable+bounces-56136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B091CF6A
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 00:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253B92823CE
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 22:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C18139D12;
	Sat, 29 Jun 2024 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pitRxgJ/"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF072594
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719699117; cv=none; b=uYbqXzQcLqxyxsacjAlu4jLYb4WSr8gYuaLYRD4qEvR0trCqSWvQ75SbbDy5Y+Vtm2utOVoHU62D1oUplqJdeROYlD0t30R/ckUypSdY+QzgjiW9r7+Ga1E9RDQx3WN6XzvYPUBC2tPqu6Sqna05W2xLsY4cwLOs94WMpY2IX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719699117; c=relaxed/simple;
	bh=leTSP2ByMgYtC4zckZLG546hQnmkCrmaDJpQbOa+5VM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o3NNCUtsZiJBA1w3pHTLyoWWUBGl+cIkUGfYsD1WfKW4UQxzLqYtRYNOi5HDKD1Qqlv4zRbAjLN8dBot+4c4QNv7tBBrztvB6gqFgUB86vvQdK5eF/DQcHR68PtPvlfc/nKlSrEwCfNW2KcfVrvEHgfSXqNydwNF4t5qf3apMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pitRxgJ/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: gregkh@linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719699112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=8p5kc8FSVinf0g6S8HeTZW4faZAzxbiRlyHgr3fxypw=;
	b=pitRxgJ/BUa7ru/4YAGw4jhpE6uQXm+xoJaunXsCQPd2JIZtbSIsXOWaRzc8VbzQiMq8NX
	xjfrEgaEsWD1X/B3YXZoseoxIdIlqOtPNpe67QNiGtXJI9zNawrVeVToyfwGYNfEqUBYvU
	5iWpjTG22lzoBxRLlnyWiVxfC7wdpmc=
X-Envelope-To: stable@vger.kernel.org
Date: Sat, 29 Jun 2024 18:11:48 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.9.y
Message-ID: <psi6r5zzddyfqixjk2yj2wymtfriasu2qqal7aszzwkypfn4tk@gicez33v2iv2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Greg, couple bcachefs fixes; this gets the downgrade path working so
6.9 works with the latest tools release.

CI testing... https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-for-v69

The following changes since commit 12c740d50d4e74e6b97d879363b85437dc895dde:

  Linux 6.9.7 (2024-06-27 13:52:32 +0200)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-20-stable-v6.9

for you to fetch changes up to 3d86d0704d4d03f76e5098ddf16152ee53f000f8:

  bcachefs: btree_gc can now handle unknown btrees (2024-06-29 16:57:24 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.9 stable

Downgrade path fixes; this fixes downgrade recovery passes not running
when downgrading from on disk format version 1.9; this results in
missing allocation information and writes immediately hanging due to the
allocator thinking there are no free buckets.

----------------------------------------------------------------
Kent Overstreet (5):
      bcachefs: Fix sb_field_downgrade validation
      bcachefs: Fix sb-downgrade validation
      bcachefs: Fix bch2_sb_downgrade_update()
      bcachefs: Fix setting of downgrade recovery passes/errors
      bcachefs: btree_gc can now handle unknown btrees

 fs/bcachefs/bcachefs.h       | 44 +---------------------------------------
 fs/bcachefs/btree_gc.c       | 15 +++++++-------
 fs/bcachefs/btree_gc.h       | 48 ++++++++++++++++++++------------------------
 fs/bcachefs/btree_gc_types.h | 29 ++++++++++++++++++++++++++
 fs/bcachefs/ec.c             |  2 +-
 fs/bcachefs/sb-downgrade.c   | 17 +++++++++++++---
 fs/bcachefs/super-io.c       | 12 +++--------
 7 files changed, 77 insertions(+), 90 deletions(-)
 create mode 100644 fs/bcachefs/btree_gc_types.h

