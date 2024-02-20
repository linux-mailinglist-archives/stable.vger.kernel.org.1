Return-Path: <stable+bounces-21425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1B885C8D8
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC711C212A3
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C200E1509BC;
	Tue, 20 Feb 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkDXEvln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124E14A4D2;
	Tue, 20 Feb 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464380; cv=none; b=sO3HdX01zR0hY/EIpyW37Izou4sgNGro9iDMdSICDNTAZZmHcpSf+5rwhZ9a3ezoe308f+bZpYce4MipOKaIcYvlMYsi7pk2y2T8T+J60fA9RWutDWS1W5vbKsPqaCHvMnGiuVpMOqECklvYNSj1Ux67CNVQy0ZmG/TflAm9a8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464380; c=relaxed/simple;
	bh=KtN01jwVKcuuk1OxIFPEvA3Nc+YJkOnkBU3RHEb51P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2B7ulOk57UL7zvd/hGsr4pe6wo/w+Z975j0V5nt8V+vWIh8fSZGOrpzCCvOFi58qrTZs3XrCY7bCNorkM7dlyu7j1vOhaTH5HPqbLy55crQh0AskozjVzdEuCFkIO7E6K89R1Zby0jmI7wdQvadwscuESZZinngzu4bWgA646o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkDXEvln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06540C433F1;
	Tue, 20 Feb 2024 21:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464380;
	bh=KtN01jwVKcuuk1OxIFPEvA3Nc+YJkOnkBU3RHEb51P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkDXEvln8TdsdvviwdJT28ObhVKu9kmbgpHI0EWxKNhKS4nkOcnP27zhfQu9swQTa
	 xDUjbo9l+tDIOykVu2ep4ZGFTlVj+NIMyG480p+C1+CAUhGM8VSw+8fKN3LFnSGg/C
	 YITl70ivGzh81OELHChwxEQAnNFzCVlbGDsWr+l0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 311/331] eventfs: Warn if an eventfs_inode is freed without is_freed being set
Date: Tue, 20 Feb 2024 21:57:07 +0100
Message-ID: <20240220205647.966911745@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

commit 5a49f996046ba947466bc7461e4b19c4d1daf978 upstream.

There should never be a case where an evenfs_inode is being freed without
is_freed being set. Add a WARN_ON_ONCE() if it ever happens. That would
mean there was one too many put_ei()s.

Link: https://lore.kernel.org/linux-trace-kernel/20240201161616.843551963@goodmis.org

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/event_inode.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -73,6 +73,9 @@ enum {
 static void release_ei(struct kref *ref)
 {
 	struct eventfs_inode *ei = container_of(ref, struct eventfs_inode, kref);
+
+	WARN_ON_ONCE(!ei->is_freed);
+
 	kfree(ei->entry_attrs);
 	kfree_const(ei->name);
 	kfree_rcu(ei, rcu);
@@ -84,6 +87,14 @@ static inline void put_ei(struct eventfs
 		kref_put(&ei->kref, release_ei);
 }
 
+static inline void free_ei(struct eventfs_inode *ei)
+{
+	if (ei) {
+		ei->is_freed = 1;
+		put_ei(ei);
+	}
+}
+
 static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 {
 	if (ei)
@@ -679,7 +690,7 @@ struct eventfs_inode *eventfs_create_dir
 
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-		put_ei(ei);
+		free_ei(ei);
 		ei = NULL;
 	}
 	return ei;
@@ -770,7 +781,7 @@ struct eventfs_inode *eventfs_create_eve
 	return ei;
 
  fail:
-	put_ei(ei);
+	free_ei(ei);
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
@@ -801,9 +812,8 @@ static void eventfs_remove_rec(struct ev
 	list_for_each_entry(ei_child, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
-	ei->is_freed = 1;
 	list_del(&ei->list);
-	put_ei(ei);
+	free_ei(ei);
 }
 
 /**



