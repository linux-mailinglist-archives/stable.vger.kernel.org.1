Return-Path: <stable+bounces-191726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CBC2036A
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 14:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7639D4E9EFA
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805CA2FC899;
	Thu, 30 Oct 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="wjNFZ6Xl"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB5285042
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830580; cv=none; b=VE6iTh9XPRwu4IwnQ+5EDUYKbOjniHZKVeZRIhpEesNW76CCNE2JokecpA9TBJxo39+dPq97TMAl+QUNmVdd8hkZg5cE3erYSP+aKykx/aNtIUbyvjrERo6WiN0V1mtonFfClj8iAqP5jIzIdQir57xLKPFLkBKOaiUlIg9a3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830580; c=relaxed/simple;
	bh=VG3NtV9xYVonaps8pUh8wMAWdcfcRM1CnYXZPSrdbcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjd5duWLO3LKWY5v45LjBqbnKnLofFupV/MNTShbqN9hIOpPRCkKBJvgvDU8zgxYZHKCCUTOqW0wVquA9N9jhcpyxdUz0WJflKnItnOr+h9qF94FnOZp3rQb69N2hEIQGpIkNjYbj2KYtCjPs/W65iKs7CX/YaZ8dfVkjfZQDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=wjNFZ6Xl; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1761829975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VG3NtV9xYVonaps8pUh8wMAWdcfcRM1CnYXZPSrdbcE=;
	b=wjNFZ6XlK8/YsdP7baK5zyvYhbqYI/FuEdmvmOdVDexJBINGEmXkhiwXiQ307MEM7hdhQE
	0HIrkjJpwVEQ/E+nQZ2pn2dwxcbPbl3cRIFOIu3fwPgRtWjJ+wkscB3JmvaBZtoEBWb7kZ
	jgN/GSz6joKsHb9J709qnWtyuGLaKDE=
To: stable@vger.kernel.org
Cc: fdmanana@suse.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: btrfs task hung in `lock_extent` syzbot report and CVE-2024-35784
Date: Thu, 30 Oct 2025 16:12:49 +0300
Message-Id: <20251030131254.9225-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi.

I've check c-repro [1] on 6.1.y branch and found that repro still produce
the crash on 6.1.y. I notice that syzbot bisection result [2]
is incorrect: indeed, the hung was fixed by upstream commit b0ad381fa769
("btrfs: fix deadlock with fiemap and extent locking"). Also,
I saw CVE-2024-35784 [3][4] vulnerability, that have direct relation with that syzbot
report. Therefore, syzbot reproducer provided additional way to check for CVE-2024-35784.

I attempted to fix CVE-2024-35784 in stable 6.1.y (over v6.1.157), and
found that the initial fix commit b0ad381fa769 ("btrfs: fix deadlock with
fiemap and extent locking") introduced regressions [5][6].
IMHO here is the minimum patch series to eliminate CVE-2024-35784 from 6.1.y:

b0ad381fa769 ("btrfs: fix deadlock with fiemap and extent locking") (Initial fix of the CVE-2024-35784)
a1a4a9ca77f1 ("btrfs: fix race between ordered extent completion and fiemap") (Fixes: b0ad381fa769)
978b63f7464a ("btrfs: fix race when detecting delalloc ranges during fiemap") (Fixes: b0ad381fa769)
1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap to avoid re-allocations") (Optimization: 978b63f7464a)
53e24158684b ("btrfs: set start on clone before calling copy_extent_buffer_full") (Fixes: 1cab1375ba6d)

Required patches attached.
Only two patches in the series have minor backport modifications due to v6.1.157 btrfs code differences.
The remaining patches are identical to the upstream.

Regards,
AK

Reported-by: syzbot+f8217aae382555004877@syzkaller.appspotmail.com

----

[1] https://syzkaller.appspot.com/text?tag=ReproC&x=12b4c88b280000
[2] https://syzkaller.appspot.com/bug?extid=f8217aae382555004877
[3] https://lore.kernel.org/all/2024051704-CVE-2024-35784-6dec@gregkh/
[4] https://cve.org/CVERecord/?id=CVE-2024-35784
[5] https://lore.kernel.org/linux-btrfs/cover.1709202499.git.fdmanana@suse.com/
[6] https://lore.kernel.org/all/20240304211551.880347593@linuxfoundation.org/


