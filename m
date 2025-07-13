Return-Path: <stable+bounces-161764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79755B03129
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8E31726D6
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808272E371E;
	Sun, 13 Jul 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfwmkSKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418CA2E36E3
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413412; cv=none; b=pj8FR4h5CWPP0aQtPzJo0IJiBVUxP5NYN+SIcrFZP4Yeyi1VDoFV5X7YE44MHLibyNB/1O9rQMSUkk4r70Ug55P/6eFV10ZXgptYFvqEiDpzzZncWxl8f3XfYQda0TDRcQL+V6c82gQ4gryprGUQl8GhGB5KKD6oNY3wRfOsgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413412; c=relaxed/simple;
	bh=GbZ6J65Xi+s0gM2CzK1bgg+JuueIHLyI/a09WUeP4aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgHao1aAL01j1watZgAtoQhQ6zh3UR2S5dn5M7/KeszgDCP8c5NA9wqVkjkhN4r8QKMq+Wm8RTx9QvcFI9jMnfzj07XECmHN/ZPjvaFYX/Xu3affNhYfD3R9Og7aI82W8sk8Id+jjZ3Rur75NvY5AbFMx4yHGl8ZvVYTeUIHMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfwmkSKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAFCC4CEE3;
	Sun, 13 Jul 2025 13:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752413411;
	bh=GbZ6J65Xi+s0gM2CzK1bgg+JuueIHLyI/a09WUeP4aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfwmkSKexsLI8fv0s51CBz7/j0UPow7QaDs87QTWNelMhGqlonaI9vEOvfUY3CtJi
	 WdXfPUCx7EvQAorj03MZlPGIYWJq0BGtowburDPg8GXoz/NgglofwyMb4+HaeB+5x7
	 RIliONT6WRmWn3py7c1SarBSpJbPyfi++dni85O3xXjcrU0aKpqRQny1AAXgV9BXQl
	 1wMai1ylEX5Ts7X11ReMn7dWMTN1J9qtuYfoKQhF2E/5E8KJg5X7T9tstIe79c8VVo
	 iVfAgQnIUI8tcNAcjCiv6iTXkWcniZgqiuOSEpX8dz0A7qD6+MJ5UOncWDaPEQlgxy
	 VTBzv0kI5CAdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] smb: client: support kvec iterators in async read path
Date: Sun, 13 Jul 2025 09:30:07 -0400
Message-Id: <20250712210459-b714759afc0353ff@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250710165040.3525304-1-henrique.carvalho@suse.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 3ee1a1fc39819906f04d6c62c180e760cd3a689d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Henrique Carvalho<henrique.carvalho@suse.com>
Commit author: David Howells<dhowells@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Found fixes commits:
92941c7f2c95 smb: fix bytes written value in /proc/fs/cifs/Stats
bb57c81e97e0 cifs: Fix rmdir failure due to ongoing I/O on deleted file
307f77e7f585 cifs: Fix reversion of the iter in cifs_readv_receive().
a68c74865f51 cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3
517b58c1f924 cifs: Fix zero_point init on inode initialisation
a07d38afd152 cifs: Fix missing fscache invalidation
61ea6b3a3104 cifs: Fix setting of zero_point after DIO write
de40579b9038 cifs: Fix server re-repick on subrequest retry
ce5291e56081 cifs: Defer read completion
a88d60903696 cifs: Don't advance the I/O iterator before terminating subrequest
8a1607233566 cifs: Fix smb3_insert_range() to move the zero_point
a395726cf823 cifs: fix data corruption in read after invalidate
edfc6481faf8 smb3: fix perf regression with cached writes with netfs conversion
14b1cd25346b cifs: Fix locking in cifs_strict_readv()

Note: The patch differs from the upstream commit:
---
1:  3ee1a1fc39819 < -:  ------------- cifs: Cut over to using netfslib
-:  ------------- > 1:  f5c5a2c4149fb smb: client: support kvec iterators in async read path
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

