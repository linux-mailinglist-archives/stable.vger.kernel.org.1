Return-Path: <stable+bounces-247972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDh1KcVFB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-247972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337C552CED
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B7FA304FC54
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BEA3FF1DD;
	Fri, 15 May 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtIatV/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485173FF1D8
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860543; cv=none; b=shSBoPOxnjjkRjtR82sg/WdUPGzEX+H7KiTKvoPjknG8p09dHiHOJGvpESN5fBKLkywfavYI6PUwxm5aezjWXDmBxLHxG5YayW/gnz55WEwxtvkfm3LXtP/ociNCyvY9ueVI0TrmaJpNbxlP58iXOW83d++o2/BRCFJCORMg/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860543; c=relaxed/simple;
	bh=rTcoDDk84QPE+2EFN0buvH8efefAu5SDcl8NblmwY2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1MXVY/sS4QRZ40LrCsegwm5DsTRSo/p7QonjJz4zFGD1o4zLFOX7W2bjqWkL45Px9cGGYYXufj3Jf0KIUL6y+IkrP3Hghvcatrgl5ZyfMTMNVhXnQhupGmPiyTmgbBCCMdT6t71IstDP9E6VzPX5kipakeE2ILaIDmAi9HNEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtIatV/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4C9C2BCB0;
	Fri, 15 May 2026 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860543;
	bh=rTcoDDk84QPE+2EFN0buvH8efefAu5SDcl8NblmwY2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtIatV/+Yo7qoD2T/kA9DRUARdbRMBP9SvYma+BAiUzGHHLOgd6kqv/3ycLhUyfCO
	 hpmLlj5ryTGYaBK9hPOmd7WpjqSOfIcicUAC84qbom5XXI0VijJf0FjdxWtmZD/pnn
	 KZ/YbrizOjhSJ9H610joYwVF2F8yl8Wo3ajQy3GgmyjzFK+kKHU+NmjFmPFM6Hceig
	 6TcIwOFwnhjvH/r9jqC9+pcoB9DPmEMiPnUK8rWKMEAgs/JPe1jwzsu40hCKTytTNL
	 D9nqzu326z1x6FU5YfZiIeSV4qXhNP5pbD96ylpbmmD5MvJZ7SZHYgjJBaOZ21hVE9
	 fflIbyeq+B49g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] eventfs: Use list_add_tail_rcu() for SRCU-protected children list
Date: Fri, 15 May 2026 11:55:40 -0400
Message-ID: <20260515155540.3359697-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051233-jiffy-shore-14d3@gregkh>
References: <2026051233-jiffy-shore-14d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5337C552CED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,goodmis.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247972-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: David Carlier <devnexen@gmail.com>

[ Upstream commit f67950b2887fa10df50c4317a1fe98a65bc6875b ]

Commit d2603279c7d6 ("eventfs: Use list_del_rcu() for SRCU protected
list variable") converted the removal side to pair with the
list_for_each_entry_srcu() walker in eventfs_iterate(). The insertion
in eventfs_create_dir() was left as a plain list_add_tail(), which on
weakly-ordered architectures can expose a new entry to the SRCU reader
before its list pointers and fields are observable.

Use list_add_tail_rcu() so the publication pairs with the existing
list_del_rcu() and list_for_each_entry_srcu().

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260418152251.199343-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ adapted scoped_guard(mutex, &eventfs_mutex) block to explicit mutex_lock()/mutex_unlock() pair ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0d2bc92b760f3..02d56ed6ad20e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -732,7 +732,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	mutex_lock(&eventfs_mutex);
 	if (!parent->is_freed)
-		list_add_tail(&ei->list, &parent->children);
+		list_add_tail_rcu(&ei->list, &parent->children);
 	mutex_unlock(&eventfs_mutex);
 
 	/* Was the parent freed? */
-- 
2.53.0


