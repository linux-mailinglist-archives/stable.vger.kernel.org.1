Return-Path: <stable+bounces-217128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGjlOjHVlGnnIAIAu9opvQ
	(envelope-from <stable+bounces-217128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:53:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4B15072D
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C6973069DCE
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E6377579;
	Tue, 17 Feb 2026 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BfAmCkRs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B6374744;
	Tue, 17 Feb 2026 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361517; cv=none; b=kmCBWQDhdrMTSDuPcqeWKNDrBudeLnvn0jdphLfIGGh5ptVyw8hiTRC7b7OSEZLBviOJQgQrX892+qOd4FpzbYoMw9EVm7WaG0sa0mK9Wus4nRGExJzyAFn5lFISffAe9Q0SqKOBXbXndkpt1PrvZqnPjz+7d5im7wEyR8VzKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361517; c=relaxed/simple;
	bh=Q2e+kLGgxw8NiaYA0Q0+2JcP0kCV5592qdkK910fer4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1OczeMEYKNDghhxFRlXgp4g2L9o+3UbCuJEoXPRjfxKjatWkzchbOgF4VgzMAXfCV32ehyyc7aMhY04WlHpVuNwRQnNqCae6m3bHMEcTZJcUGpL5uuZGqcLCfFV6QhliI4jti7jCasQveLxJ7jasQhbTkGXd3G66uFtTsXIe0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BfAmCkRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79C8C4CEF7;
	Tue, 17 Feb 2026 20:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361517;
	bh=Q2e+kLGgxw8NiaYA0Q0+2JcP0kCV5592qdkK910fer4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BfAmCkRsmS5GpWPQhr7uQk+pXAOq+gRceBWfXsO5WUdLqL9BmC1m67BBw0M5yWc5H
	 BpjQeI1XN6kkivD0PlVUZIr4/k9N9OI7jE7FYzwOoVens3pW+bWtre/9dRKSCvyFgB
	 K5SnhBHQn5wfCEpOnswrU7RYzV8upf7yMJZ009q8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 32/43] f2fs: fix to add gc count stat in f2fs_gc_range
Date: Tue, 17 Feb 2026 21:32:12 +0100
Message-ID: <20260217200007.701045716@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
References: <20260217200006.470920131@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217128-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unisoc.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CE4B15072D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

commit 761dac9073cd67d4705a94cd1af674945a117f4c upstream.

It missed the stat count in f2fs_gc_range.

Cc: stable@kernel.org
Fixes: 9bf1dcbdfdc8 ("f2fs: fix to account gc stats correctly")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/gc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2093,6 +2093,7 @@ int f2fs_gc_range(struct f2fs_sb_info *s
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
+	stat_inc_gc_call_count(sbi, FOREGROUND);
 	for (segno = start_seg; segno <= end_seg; segno += SEGS_PER_SEC(sbi)) {
 		struct gc_inode_list gc_list = {
 			.ilist = LIST_HEAD_INIT(gc_list.ilist),



