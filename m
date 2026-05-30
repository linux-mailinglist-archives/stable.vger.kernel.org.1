Return-Path: <stable+bounces-257351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jt5NLsYG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:04:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6DB60EDB6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95F9C300F5C4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96154366567;
	Sat, 30 May 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/tnHqpV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29932B11D;
	Sat, 30 May 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160692; cv=none; b=TmjTLReWjn9iq/DGGwg8DW0Qu/vALXUbhmgdSfQ7lr0LpB5wFqBPQCghsfft9h5yW33njW1xfbtlkJRRs2rkoUBV/+0PruExebEAV7GJvB0x6NFdzBX+eWO3Apcb+AWCuWpRz5uSvxhMMl+K0vpRNNTd4JYu8otZR4kPceMmJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160692; c=relaxed/simple;
	bh=Hvg3B9nu1qNIjgYDpn/g78U7IMkW9fhIrw6Gf5rdCqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgmfBsByee0qdWbwI+cYjg08ipo1BQH8PfV+4yELpCskJiiUu0c1o5PbLEGZQUOk1aKlsm+rVYx+mwW9ncfho+45vIwV4Rfmz8IdFWujeUniNzixs9Zm3c/jSE069Igf+z5iSgFChNJS4Fcqv80v27VehrAzXBFm/qwM9QNwPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/tnHqpV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DB51F00893;
	Sat, 30 May 2026 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160691;
	bh=Qp8WZ4XUeri2DzNXQgV+LWHPmnige5Vh+cSCPk8tr30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y/tnHqpV0orIARECpPEa+lO8VWtcG9liXztZqZTnpi6cjPhf5orlo0GxWqfZ4+y/E
	 KBXS1A+qOeBwRFgNX73I5/ZqVZQgcWITdgOO1OK/6enRRNu7YaYF7ubqc78Tn0hGSS
	 BtZ8cdWEaRAK/utOc/4rPUL1/wIHQ8k/MolWEUK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.1 377/969] f2fs: fix incorrect multidevice info in trace_f2fs_map_blocks()
Date: Sat, 30 May 2026 17:58:21 +0200
Message-ID: <20260530160310.714367343@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257351-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5D6DB60EDB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

commit eb2ca3ca983551a80e16a4a25df5a4ce59df8484 upstream.

When f2fs_map_blocks()->f2fs_map_blocks_cached() hits the read extent
cache, map->m_multidev_dio is not updated, which leads to incorrect
multidevice information being reported by trace_f2fs_map_blocks().

This patch updates map->m_multidev_dio in f2fs_map_blocks_cached() when
the read extent cache is hit.

Cc: stable@kernel.org
Fixes: 0094e98bd147 ("f2fs: factor a f2fs_map_blocks_cached helper")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1487,7 +1487,8 @@ static bool f2fs_map_blocks_cached(struc
 		f2fs_wait_on_block_writeback_range(inode,
 					map->m_pblk, map->m_len);
 
-	if (f2fs_allow_multi_device_dio(sbi, flag)) {
+	map->m_multidev_dio = f2fs_allow_multi_device_dio(sbi, flag);
+	if (map->m_multidev_dio) {
 		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 



