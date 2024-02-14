Return-Path: <stable+bounces-20161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56E85471D
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 11:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA87B285C3
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897C182C3;
	Wed, 14 Feb 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YEKDgmjs"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC617552
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906323; cv=none; b=nEuCeRZ2WpOpvEFlYe2UGiQRVqsCyfPHu0xJv4R12DqLYAPPJfsBpgcNpVq1uoQAoI62Nw1BRG4n4eMc2ps20RRjKnY+DwyJ1cKZ3uG/8QLBhxdyrC23N1tTS9Dw3xHDfsORQjs949/RSE0WO2L5BwIlvekRF/xFUYkeJCqkbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906323; c=relaxed/simple;
	bh=ZPoaJsvlNijU/h+dpSnh0fxlGLkAP0U99MyN3QMfKAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMDzpdzg0SPpqxlHj/Y4l3Ve9uhqqpDwtmFQh5uipHJ2UI/sb6cVWrUTzS8BZ9Jkod1Q7ZlVPKsa3Mgw5tR50+UGpHl+K0xpSLCniFvZDX/QwPEwH5SuxjzXmdAz84OhA3aM0Qgdo5IaQVE0U3KmcFEl1xuVE/gADVMSgsYu6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=YEKDgmjs; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:36ad:0:640:5aad:0])
	by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 7287263FAC;
	Wed, 14 Feb 2024 13:23:36 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:6505::1:28])
	by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id UNlXS85IZW20-z4OBrOLK;
	Wed, 14 Feb 2024 13:23:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1707906215;
	bh=phU6Z/3Zq4wkbGT7NbnAyeu5q/Njt7aW6m+8sjbUBCg=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=YEKDgmjs9aVAJCYxRggA5QMMvtQxYloVv1QIvTA5TBif5pXFh73C4xRh9j04iQ9B2
	 ezWtuHg0GgmVXnVXbbLFYg5SGPhnvAbT6wbdYhMZ+bbUUigcUbn0JH0V8aF03r6wbS
	 caulTRIBgVd573RDMsJ84QTTUdXW+yeVJv0cXXsw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tytso@mit.edu,
	lvc-project@linuxtesting.org,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH 5.15 0/1] ext4, jbd2: add an optimized bmap for the journal inode
Date: Wed, 14 Feb 2024 13:23:08 +0300
Message-Id: <20240214102309.1382551-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's already into 6.6 and fixes the Syzkaller issue
Link: https://syzkaller.appspot.com/bug?id=e4aaa78795e490421c79f76ec3679006c8ff4cf0
Theoretically the issue boils down to
commit 51ae846cff56 ("ext4: fix warning in ext4_iomap_begin
as race between bmap and write")
so it should be in 5.10, 5.15 and 6.1 kernels.
But we at Linux Verification Center can reproduce it with 5.15 and 6.1 only
so I'm asking to apply the fix for those two.

Theodore Ts'o (1):
  ext4, jbd2: add an optimized bmap for the journal inode

 fs/ext4/super.c      | 23 +++++++++++++++++++++++
 fs/jbd2/journal.c    |  9 ++++++---
 include/linux/jbd2.h |  8 ++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.34.1


