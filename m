Return-Path: <stable+bounces-138285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1860AA17AE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB543B4C4D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D491221570;
	Tue, 29 Apr 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oB4cu+gv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A5C148;
	Tue, 29 Apr 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948773; cv=none; b=kBlIWUXOizFPptl+NZmX27/KK/KMqfRmnpx0IKlc/NV/xnmcB40y6udXHgK3ZUD6kr6rs/fwnpoxgtwtqWWuzl1Ws+7RR7z3roQiWEY9NkMAmStoeCJQPv+VN7qtXMUe6NO7p+t/fh9jlmieRGmAilq3vBwI1ax1w/+CUGZHLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948773; c=relaxed/simple;
	bh=6Ho1E3gyhDy6Br/JoGTwYOxa8YWX3kAO+qeab3HJMEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeElHHf2+uh70P3Nfmh9a1UJTtkki1ngB2gQ4rXDVS7Pna5HShiVj+N1cjkqhTEFgkYxjOH22hsyiPS73v09NCVqoneOhwwa/le3rW+jRe9QnvREPG1sctboo4k/zAqc4YN234Lw2PG6LnIrXJyY6zfqSaUxYjvG9JHmQNpf674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oB4cu+gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2141C4CEE3;
	Tue, 29 Apr 2025 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948773;
	bh=6Ho1E3gyhDy6Br/JoGTwYOxa8YWX3kAO+qeab3HJMEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB4cu+gvQjbLGZhIr3F2qMqA8ZvGBaSFl9CKDUkdUJyFLoZFgJKdEylMIejafgm+r
	 UvxniMDwb7T56YnPqXUxb7CxlhL+wCqb8JW4ZtBTQuAuFneifnHRi+sqPgy7Iis9Me
	 ZF8PVqmr8CTtKS9b4IHfGtWNOJwNFF3L7OPGiT1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.15 090/373] jbd2: remove wrong sb->s_sequence check
Date: Tue, 29 Apr 2025 18:39:27 +0200
Message-ID: <20250429161126.863469953@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit e6eff39dd0fe4190c6146069cc16d160e71d1148 upstream.

Journal emptiness is not determined by sb->s_sequence == 0 but rather by
sb->s_start == 0 (which is set a few lines above). Furthermore 0 is a
valid transaction ID so the check can spuriously trigger. Remove the
invalid WARN_ON.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250206094657.20865-3-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/journal.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1701,7 +1701,6 @@ int jbd2_journal_update_sb_log_tail(jour
 
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
-	WARN_ON(!sb->s_sequence);
 	journal->j_flags &= ~JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
 



