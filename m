Return-Path: <stable+bounces-243306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJMcCj6o+GlexgIAu9opvQ
	(envelope-from <stable+bounces-243306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4C4BE92D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 310AE300A31C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC793DEAD6;
	Mon,  4 May 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zbJxSSBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEA23DEAC3;
	Mon,  4 May 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903547; cv=none; b=D/M+OCnuefiX1VzC9+5KOw7L9VWh83DFYrfAIuA0weP+rs5KG1bKt/Qkniv+G31+gdvfBxPgofIs8tfwSnRyiNYhAEIxH+dpPWMJcuHkrxC+PwfPXaL8tPD3UwTRMxOAJfk5cJ0duEg8qdy2TbQ4NLYPf5bhiSsGwFkDiUBNFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903547; c=relaxed/simple;
	bh=b/iUfD9Ozl6F73BHvU38QXCQ9hPA9jFJM9SEvbThDNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1PcXaJjxfbF3oOhtUEnACETEXepyu/gm1fOdmsKH9JoS2bLSvx9uGYkpJfVgRkhQSUOd+4thOgcHaLClNhuvXDFME0PzJyQTaoNH6hUUy+FrxF8FQaxW+7U/Uy6FSnZOlOXOb/z9O/pHMNJFYhYoe2Htn8PYnjNbN/FQO1tKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zbJxSSBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD62EC2BCF4;
	Mon,  4 May 2026 14:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903547;
	bh=b/iUfD9Ozl6F73BHvU38QXCQ9hPA9jFJM9SEvbThDNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zbJxSSBZb1JHpJ+F7tr1ri/CkNXwS66NIfIwRHqsCFfU2hi21DOrbIIH+LyLO8bJ2
	 A7JO/sUjdT8b6ufNE1tCVW63jigrtfUnKsjUSG1P02nLVImD8dgwn9/0ZGFfLSYc+W
	 I58JgxCMCK7ie3wJM36eEEurQV3BmfM+xUZKW4TM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chia-Ming Chang <chiamingc@synology.com>,
	robbieko <robbieko@synology.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 7.0 244/307] inotify: fix watch count leak when fsnotify_add_inode_mark_locked() fails
Date: Mon,  4 May 2026 15:52:09 +0200
Message-ID: <20260504135152.010548549@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: ADF4C4BE92D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243306-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,synology.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chia-Ming Chang <chiamingc@synology.com>

commit 6a320935fa4293e9e599ec9f85dc9eb3be7029f8 upstream.

When fsnotify_add_inode_mark_locked() fails in inotify_new_watch(),
the error path calls inotify_remove_from_idr() but does not call
dec_inotify_watches() to undo the preceding inc_inotify_watches().
This leaks a watch count, and repeated failures can exhaust the
max_user_watches limit with -ENOSPC even when no watches are active.

Prior to commit 1cce1eea0aff ("inotify: Convert to using per-namespace
limits"), the watch count was incremented after fsnotify_add_mark_locked()
succeeded, so this path was not affected. The conversion moved
inc_inotify_watches() before the mark insertion without adding the
corresponding rollback.

Add the missing dec_inotify_watches() call in the error path.

Fixes: 1cce1eea0aff ("inotify: Convert to using per-namespace limits")
Cc: stable@vger.kernel.org
Signed-off-by: Chia-Ming Chang <chiamingc@synology.com>
Signed-off-by: robbieko <robbieko@synology.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20260224093442.3076294-1-chiamingc@synology.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/inotify/inotify_user.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -621,6 +621,7 @@ static int inotify_new_watch(struct fsno
 	if (ret) {
 		/* we failed to get on the inode, get off the idr */
 		inotify_remove_from_idr(group, tmp_i_mark);
+		dec_inotify_watches(group->inotify_data.ucounts);
 		goto out_err;
 	}
 



