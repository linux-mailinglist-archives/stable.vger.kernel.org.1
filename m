Return-Path: <stable+bounces-229285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GBaF29vwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:50:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D634D2F8E8D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F18234491FC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F383B4EBC;
	Mon, 23 Mar 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uGeMa8JV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8441A00F0;
	Mon, 23 Mar 2026 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278637; cv=none; b=BLuXfvLimmQ/3RmmstEU1OwDKN20RLREx8oq+kCpwQHOYFxzR8XN9BkehKU/C4dkdgYy/kuzQC2fr5+cqvqS5VqEndKpuRN2lfuYyMlYJI7Opp68kxz4x8UVZUyWaklVrUMPpC7PZ7RFcpKw+LW0vKRZ1JXoINids5nvtOkeYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278637; c=relaxed/simple;
	bh=HcomlFf98fbDfsKOGt0R3SmRFkQYqI4K6BpnIRLX9tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmQdl4qS9102q1UHEvNguV1UXG/66rFGa/3B2NDe7vV5CaxmwMMeuGytt4MxdHNFA8Ica8Mub0lNR07jc4JM9sWGMRr1L4MWeg4AG50/v6Tf3rsj0kBKVoqPTgBd6zmI9naue+KU4KmyZYIB/Wd8BDreZOc36Posug96bbj9U4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uGeMa8JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506EFC4CEF7;
	Mon, 23 Mar 2026 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278637;
	bh=HcomlFf98fbDfsKOGt0R3SmRFkQYqI4K6BpnIRLX9tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGeMa8JVzt8GSX0Kiw3teY0X0luszpglSLwX8t5IK4vHNUH6f1rPea+OOrKdlQaLi
	 rlaMBS2kaJTmEN2CDgc8OM7RKw8X13fUvVvV7BULilRR4qvYUzoFQrgRYzBy56ic26
	 cgNUetbg4NFcRMh6EBFbTGBSzTu2L6KaA1tGO168=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 328/567] ksmbd: fix use-after-free in smb_lazy_parent_lease_break_close()
Date: Mon, 23 Mar 2026 14:44:08 +0100
Message-ID: <20260323134541.947706856@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229285-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D634D2F8E8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit eac3361e3d5dd8067b3258c69615888eb45e9f25 upstream.

opinfo pointer obtained via rcu_dereference(fp->f_opinfo) is being
accessed after rcu_read_unlock() has been called. This creates a
race condition where the memory could be freed by a concurrent
writer between the unlock and the subsequent pointer dereferences
(opinfo->is_lease, etc.), leading to a use-after-free.

Fixes: 5fb282ba4fef ("ksmbd: fix possible null-deref in smb_lazy_parent_lease_break_close")
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/oplock.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1123,10 +1123,12 @@ void smb_lazy_parent_lease_break_close(s
 
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
-	rcu_read_unlock();
 
-	if (!opinfo || !opinfo->is_lease || opinfo->o_lease->version != 2)
+	if (!opinfo || !opinfo->is_lease || opinfo->o_lease->version != 2) {
+		rcu_read_unlock();
 		return;
+	}
+	rcu_read_unlock();
 
 	p_ci = ksmbd_inode_lookup_lock(fp->filp->f_path.dentry->d_parent);
 	if (!p_ci)



