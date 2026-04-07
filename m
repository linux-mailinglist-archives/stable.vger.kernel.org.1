Return-Path: <stable+bounces-233694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M9JERM81WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:17:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B043B2439
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA003023505
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93205339714;
	Tue,  7 Apr 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nwvdPUeD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="onTavs78"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC8303A37;
	Tue,  7 Apr 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582202; cv=none; b=RZSGZo0egXa3X8cWG+aMWRgexW/gI7rKSaO3Bi+MB/2myQP0/8bTzBihTjqpCPvsRAOoitKI1MwW7T6Nrg0QFP2qZz+xxPfG6CXSaOzDpeZ+aAOpx1dXDT2pHnIg81b+epjevBoed9G/MT/xEhN0SFZJpv4MpA0Ig9yhj/K7/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582202; c=relaxed/simple;
	bh=hM2XUXPoIDYLSjP+/KTrF5awXYnBkmdlM1IybsbYYjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NC5KPRijPXz96OZv6ZhDalVRh8ayj33UIOWb5f/sKs2NZa73rOw1FtmDszwummwlbHHUWGWrIKlxB4GSdrtBEGVyZQ3IYS3+spTLbXjMNoMoPEmvlwYPeSlbzdLyQJbjeOPUfcCfFPIhFXtT+n77XqkBcgzG6g8qIW0613lHjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nwvdPUeD; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=onTavs78; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fqtCM5swyzB0xJ;
	Tue,  7 Apr 2026 19:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2PA7xCx97TEAuzYmmiZwCMtjFGZYSyx4V6yHSoLVI/I=;
	b=nwvdPUeDPGTRKVGgGJRef2iMUEeivlso60Bcvnd6z8ua2Nh+4J8dXFJTF0pty2HCMaL6UZ
	5ENgJeTchcupsXhB6GOp2yekRraV+TmKk8ucmioUaQ6yEQKJ43LmOhkQ7R5pWLkIV1Pfru
	6OLIU88xUAD1FqecQlSxjHDA4N2vSHxwXzEwLZ0iD36QsqT46DUuM0aB4CzIwPMHjVMD85
	r/OFoooPluJfHHVS5wOP6VOLoKu3Lk4UEfLnJhTTLpAYnHjVjFe9OvPtUgUI/w8449YYDo
	iGkhpYbx2SMsUGzY3e284njVYqkFI61JIwV4o/xQi/g8+e8lB0FdmYaeOMuLGg==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2PA7xCx97TEAuzYmmiZwCMtjFGZYSyx4V6yHSoLVI/I=;
	b=onTavs788rmYy7PpZDimSU+6mSY0ocUMe3kAAYjIZaXVWi7BPswjBLz8LytPfrse/6ksoe
	tJGBS8IJUATQaKYhJbsPaQS9iy89hX2HL+VnotAOg7zpnEeJFgfoel7AsqZDvJRGoj05eS
	Qrf9hACxBkQXkCYjaKvkgtB9DqMEuYMVb4HbPOTrOyYXilo5JNTglaixpspcXAolOTrUvK
	LwMuyVA78XXIV5oqA8Egx1Gl64upSXgJQwwgTnq3MXW54r19CGyK13yOhviflRzZmAOkLN
	CwORyeAygafAptCvdtC9awVzl6jKv56O2Vj8CbDMVOnZ2JsV/5W6GLg5qSfOig==
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gregkh@linuxfoundation.org,
	ben@decadent.org.uk,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 0/3] net: fix three security bugs in NET/ROM and ROSE stacks
Date: Wed,  8 Apr 2026 01:15:57 +0800
Message-ID: <20260407171600.102988-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 75tnszh3syzh39qoy89warp8zo197oq5
X-MBO-RS-ID: b14e8d03dc0354285bf
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233694-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1B043B2439
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes three bugs in the Linux kernel AX.25 protocol stack,
submitted on top of Greg Kroah-Hartman's frame-size validation series
(https://lore.kernel.org/r/2026040730-untagged-groin-bbb7@gregkh).

Patch 1 fixes an integer overflow in nr_queue_rx_frame(): nr_sock.fraglen
is declared as unsigned short and accumulates received fragment lengths
without overflow protection.  When total received data exceeds 65535 bytes,
fraglen wraps to a small value, causing alloc_skb() to allocate a tiny
buffer followed by a full-length copy -- a heap out-of-bounds write.

Patch 2 fixes nr_find_socket() dispatching incoming NR_INFO frames by
matching only the circuit index/id bytes without validating the source
callsign against the socket's dest_addr.  Any node can inject frames into
an existing STATE_3 connection by guessing the circuit ID (the value space
is only 65025 non-zero pairs and IDs are assigned sequentially).  Combined
with the fraglen overflow in patch 1, this gives an unauthenticated
attacker a complete heap corruption primitive.

Patch 3 fixes an out-of-bounds read in rose_parse_ccitt(): the function
validates 10 <= l <= 20 but never checks that the remaining buffer is at
least l+2 bytes before calling memcpy().  rose_parse_national() already
performs the equivalent check; this patch adds the same guard.

Mashiro Chen (3):
  net: netrom: fix integer overflow in nr_queue_rx_frame()
  net: netrom: validate source address in nr_find_socket()
  net: rose: fix out-of-bounds read in rose_parse_ccitt()

 net/netrom/af_netrom.c | 11 +++++++----
 net/netrom/nr_in.c     | 10 ++++++++++
 net/rose/rose_subr.c   |  3 +++
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.53.0


