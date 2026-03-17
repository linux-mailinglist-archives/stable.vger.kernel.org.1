Return-Path: <stable+bounces-225932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF6gDlRPuWnj/wEAu9opvQ
	(envelope-from <stable+bounces-225932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:55:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 847032AA3A6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADF0130CF798
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C4B3C5528;
	Tue, 17 Mar 2026 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d1v2JnPy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8F3AE19B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751972; cv=none; b=BypmRaeE8Zk3uDdjXkCStf1vgfiZ8P1o4glc0v/QQjTxudBEgv4c6faC0Z/yyjbUBqewzg9uj1AgfsYxWTN+3+NjoiJmKiptUkpdT/vEyhrYpMlxHks0MlxAPZtL7dhpzRdmrBI5bDmDLH6qLN/alVoaeuH78jHp2CYYnX+PZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751972; c=relaxed/simple;
	bh=r5NTtznrKJu8O9YjIdrchaEBbkzWHiwuf/w3NiWcxPI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b6l2ZtisjPk5/jpukF5WDhsW9pTay6b3TC27tI75pbZfjE8adX+aoHYK9xA3cqPplRvWkDLqCZ/bExUwLKTeosGtsWEQ3jGcvsqI7PUa7JoeMTJT/DpOzlP5P7IMAZ8nZvfW2vRF9tgMPa+qpgZnkzMdMHFSIvUlG1CdlXKzg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1v2JnPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A95C4CEF7;
	Tue, 17 Mar 2026 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773751972;
	bh=r5NTtznrKJu8O9YjIdrchaEBbkzWHiwuf/w3NiWcxPI=;
	h=Subject:To:Cc:From:Date:From;
	b=d1v2JnPyu+7oihcCh1c+dFjXyJyI04I4TRQBcAmqcn+mN34n42yhy6YCMTwmHlvoh
	 bO4LNMekmChKYt3yli1hw3PeiEPSS6dCd6vM2O1h8onOc4hvIrct8B5+IPUtQADptE
	 BHYtUub1SerSWUh0z8VoSslmIqiHLlbLnKj8Lgy4=
Subject: FAILED: patch "[PATCH] netconsole: fix sysdata_release_enabled_show checking wrong" failed to apply to 6.18-stable tree
To: leitao@debian.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:52:41 +0100
Message-ID: <2026031741-agility-clench-4090@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225932-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 847032AA3A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5af6e8b54927f7a8d3c7fd02b1bdc09e93d5c079
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031741-agility-clench-4090@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5af6e8b54927f7a8d3c7fd02b1bdc09e93d5c079 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Mon, 2 Mar 2026 03:40:46 -0800
Subject: [PATCH] netconsole: fix sysdata_release_enabled_show checking wrong
 flag

sysdata_release_enabled_show() checks SYSDATA_TASKNAME instead of
SYSDATA_RELEASE, causing the configfs release_enabled attribute to
reflect the taskname feature state rather than the release feature
state. This is a copy-paste error from the adjacent
sysdata_taskname_enabled_show() function.

The corresponding _store function already uses the correct
SYSDATA_RELEASE flag.

Fixes: 343f90227070 ("netconsole: implement configfs for release_enabled")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260302-sysdata_release_fix-v1-1-e5090f677c7c@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2db116fb1a7c..3c9acd6e49e8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -617,7 +617,7 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	bool release_enabled;
 
 	dynamic_netconsole_mutex_lock();
-	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	release_enabled = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	dynamic_netconsole_mutex_unlock();
 
 	return sysfs_emit(buf, "%d\n", release_enabled);


