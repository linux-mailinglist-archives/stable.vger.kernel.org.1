Return-Path: <stable+bounces-61288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C293B23C
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 16:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE9A1F241C1
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C5158D61;
	Wed, 24 Jul 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SlkgNNtZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39250DDC5;
	Wed, 24 Jul 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830068; cv=none; b=hOuxKbwGd6zEyGoV6TiEphzttMoaxliyN64YMgXO3yPz3DxUCr1bzlIpyKnJLP97be8yq2+gc6NQiKHpSyuMq6J1wdxUJNyAyBGs3wdUIu9bNgtK3O86gg/wdPABA24X8e5aAb0XDGhlyU4dbuaGSGH6zeangIXcYQv3x9tV8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830068; c=relaxed/simple;
	bh=Rx4hpTTYYqVSZdC8XTwnfXY5UsSWi7uSuGAt/czcwwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOLDnzg6wH3q6Y8nOXSYBjE9FYzg2A4TL/xhwhfolOzKkG3LOR6m4QWfg0eq1VmGn2ikswQTlRYOLKddgFbypXGNawbtQnNcZxXwineEud1BKIZCVzjNiGJ1to63Iz0uuZKw2YaGAsMr6uIpuON3ztlTgH7tWe1oANN/uVRQFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SlkgNNtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78378C32781;
	Wed, 24 Jul 2024 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721830067;
	bh=Rx4hpTTYYqVSZdC8XTwnfXY5UsSWi7uSuGAt/czcwwg=;
	h=From:To:Cc:Subject:Date:From;
	b=SlkgNNtZVQomNe3BqXM9wWTPa3wNl3VGz+1UR78FOtN7AnQvy0PeV+Wk0B6YN6ONg
	 MJmtaZKQLjXpoH7mXyVt4mKKNRMnQAPEpDlTcfZnnwWHgMemXn9KFQ3YYt5o+Bfkjc
	 DflQiZU0dzr62XQtGEQHhQwG1oRzB/JvATqm3AL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.1
Date: Wed, 24 Jul 2024 16:07:37 +0200
Message-ID: <2024072438-spinning-unrated-6d57@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.1 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                    |    2 -
 drivers/char/tpm/tpm2-sessions.c            |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    7 +++
 drivers/thermal/thermal_core.c              |   51 +++++++++++++---------------
 drivers/thermal/thermal_core.h              |    3 +
 drivers/thermal/thermal_helpers.c           |    2 +
 fs/ext4/ext4.h                              |    2 -
 fs/ext4/ioctl.c                             |    2 -
 fs/smb/client/cifsfs.c                      |    2 -
 fs/smb/client/file.c                        |   21 +++++++++--
 fs/smb/client/smb2pdu.c                     |    3 -
 include/sound/cs35l56.h                     |    2 -
 io_uring/kbuf.c                             |    4 +-
 sound/soc/codecs/cs35l56.c                  |    6 ++-
 14 files changed, 68 insertions(+), 44 deletions(-)

David Howells (4):
      cifs: Fix missing error code set
      cifs: Fix missing fscache invalidation
      cifs: Fix server re-repick on subrequest retry
      cifs: Fix setting of zero_point after DIO write

Greg Kroah-Hartman (1):
      Linux 6.10.1

Hao Ge (1):
      tpm: Use auth only after NULL check in tpm_buf_check_hmac_response()

Kees Cook (1):
      ext4: use memtostr_pad() for s_volume_name

Pavel Begunkov (1):
      io_uring: fix error pbuf checking

Rafael J. Wysocki (1):
      thermal: core: Allow thermal zones to tell the core to ignore them

Richard Fitzgerald (2):
      ASoC: cs35l56: Use header defines for Speaker Volume control definition
      ASoC: cs35l56: Limit Speaker Volume to +12dB maximum

Steve French (1):
      cifs: fix noisy message on copy_file_range


