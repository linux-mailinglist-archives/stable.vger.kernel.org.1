Return-Path: <stable+bounces-225122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB4DNu4gs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8EF278F75
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2BC43025250
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07C374E44;
	Thu, 12 Mar 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxmyZqqa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDC37416E;
	Thu, 12 Mar 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347050; cv=none; b=hGbSGmpx8sc+ZmCCpyJihCIVWi5voQexJKyIPCKPp4sC37xFk0G138sx8qn94ikdA874Lh0lBHsR2VYov9SPgPtBqEOM1ojA3fHdq0mTpBEMG+61XUzWtiq9Ot7CyWGVcZibSHptRWis8X2tSHdjlG1PIrmtnBGzMUZAC/g6IQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347050; c=relaxed/simple;
	bh=JJl/oraBkLn77d+qWwALQAlqKFt4DH2evKXfcvQKAps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlrT44c3EJ1gl7J8CLrG+M5vW/0/oFkegGq9/ELI+BrAIEaRcqTNoBR/DfWOtrt9ZhaqLRyRGca4mki9g4oQWbLuX1c7Uf13U8q9EHFjOCqUCnphq1u5TRDz+VEWeLuyEnfwGVV4oh1MDt3pWkz3nld8SMZfmUTDDoTUDqITryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxmyZqqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8838C4CEF7;
	Thu, 12 Mar 2026 20:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347050;
	bh=JJl/oraBkLn77d+qWwALQAlqKFt4DH2evKXfcvQKAps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxmyZqqaWlu3xneHp9WdBCzJ/azXCSVaR/mn0cis52qUiodlaAPTaM2UHt7akSQmC
	 O5udP4ICOIGTS/i+75hcvfbEY4hd53JRcxxRqP2pya6tsiHLiuv/ElcOBDiwY4T5uq
	 5f9jYuBMxWDwgsx/gMHd6a4NWcN9mfRslECSE/rw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 157/265] smb: client: fix cifs_pick_channel when channels are equally loaded
Date: Thu, 12 Mar 2026 21:09:04 +0100
Message-ID: <20260312201023.941657892@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225122-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B8EF278F75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henrique Carvalho <henrique.carvalho@suse.com>

commit 663c28469d3274d6456f206a6671c91493d85ff1 upstream.

cifs_pick_channel uses (start % chan_count) when channels are equally
loaded, but that can return a channel that failed the eligibility
checks.

Drop the fallback and return the scan-selected channel instead. If none
is eligible, keep the existing behavior of using the primary channel.

Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Acked-by: Meetakshi Setiya <msetiya@microsoft.com>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/transport.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1026,16 +1026,21 @@ cifs_cancelled_callback(struct mid_q_ent
 }
 
 /*
- * Return a channel (master if none) of @ses that can be used to send
- * regular requests.
+ * cifs_pick_channel - pick an eligible channel for network operations
  *
- * If we are currently binding a new channel (negprot/sess.setup),
- * return the new incomplete channel.
+ * @ses: session reference
+ *
+ * Select an eligible channel (not terminating and not marked as needing
+ * reconnect), preferring the least loaded one. If no eligible channel is
+ * found, fall back to the primary channel (index 0).
+ *
+ * Return: TCP_Server_Info pointer for the chosen channel, or NULL if @ses is
+ * NULL.
  */
 struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 {
 	uint index = 0;
-	unsigned int min_in_flight = UINT_MAX, max_in_flight = 0;
+	unsigned int min_in_flight = UINT_MAX;
 	struct TCP_Server_Info *server = NULL;
 	int i, start, cur;
 
@@ -1065,14 +1070,8 @@ struct TCP_Server_Info *cifs_pick_channe
 			min_in_flight = server->in_flight;
 			index = cur;
 		}
-		if (server->in_flight > max_in_flight)
-			max_in_flight = server->in_flight;
 	}
 
-	/* if all channels are equally loaded, fall back to round-robin */
-	if (min_in_flight == max_in_flight)
-		index = (uint)start % ses->chan_count;
-
 	server = ses->chans[index].server;
 	spin_unlock(&ses->chan_lock);
 



