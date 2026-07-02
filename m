Return-Path: <stable+bounces-271348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MWPwLV2aRmpxZwsAu9opvQ
	(envelope-from <stable+bounces-271348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 357496FAF72
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="lPj/vuuF";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271348-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271348-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27BB530E6E05
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC044433E87;
	Thu,  2 Jul 2026 16:55:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E31C695;
	Thu,  2 Jul 2026 16:55:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011308; cv=none; b=SYqIBhpQz6ThdKRgTMZwbf7R2Xw17WoAuxfjTDu0Mwm9zKEc943xv6WS06l6g7RL6uOiM1y8CUY8R6W3wSAtT7sEG11glMdbo7Ow/3UXWgsiRF8I5iTHpKqvFXDAD2/37mtRjS8uzbJnL1J7JvrNFzJGGz+sI0OulXNsqmknIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011308; c=relaxed/simple;
	bh=gLMWIIpu0bq6XZffRdAyjSGUQduMYRhkjsbLVyzkFrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZVdbZPNgtqJJ0qLOxsdL4xGWSt/bh7+vyEJw8egH6oKYCPiCAmkEc+H0GMDLYMswXwlouEYMV8vOEzzVjWPIJtqjNKDWJBEuTAw3F6J+T7fuvJTLQuu4Q3ykJWBCRuIoCdscSl561uwGxEusvht49CUzrw5RE8Y9kS0639iMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lPj/vuuF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B3D1F000E9;
	Thu,  2 Jul 2026 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011307;
	bh=P0xbvNB580ggDpwxjS/ajbpJKqdbJF09w/VJF/Kd5K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPj/vuuFrqc3tv3CM3bZQcKfqkHUtjlU0+EQiMF9wd1bt9D1gnPkA6pmoTvJR3NP1
	 Fae9uXfMHWDhbhqS+TYnxamfEArtZmjt2ignUgeiRlrMzMHVfXKFH9G9HLzmZTkiEt
	 3rKlwXQuaP7Gfi4fvWtLbikY8B4UzeLclOXlaTzc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 060/108] f2fs: pass correct iostat type for single node writes
Date: Thu,  2 Jul 2026 18:20:57 +0200
Message-ID: <20260702155113.351025228@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271348-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:qiwenjie@xiaomi.com,m:chao@kernel.org,m:jaegeuk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,xiaomi.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 357496FAF72

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjie Qi <qwjhust@gmail.com>

commit fcb05c26c2a67953b420739b85f49386efc9b6c0 upstream.

f2fs_write_single_node_folio() takes an io_type argument, but still
passes FS_GC_NODE_IO to __write_node_folio() unconditionally.

This was harmless while the helper was only used by
f2fs_move_node_folio(), whose caller passes FS_GC_NODE_IO. However,
commit fe9b8b30b971 ("f2fs: fix inline data not being written to disk
in writeback path") made f2fs_inline_data_fiemap() call the helper with
FS_NODE_IO for FIEMAP_FLAG_SYNC.

Honor the caller supplied io_type so inline-data FIEMAP sync writeback is
accounted as normal node IO instead of GC node IO, while the GC path
continues to pass FS_GC_NODE_IO explicitly.

Cc: stable@kernel.org
Fixes: fe9b8b30b971 ("f2fs: fix inline data not being written to disk in writeback path")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1853,7 +1853,7 @@ int f2fs_write_single_node_folio(struct
 	}
 
 	if (!__write_node_folio(node_folio, false, false, NULL,
-				&wbc, false, FS_GC_NODE_IO, NULL))
+				&wbc, false, io_type, NULL))
 		err = -EAGAIN;
 	goto release_folio;
 out_folio:



