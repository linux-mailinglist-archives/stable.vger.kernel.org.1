Return-Path: <stable+bounces-236879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBJtJG4d3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 392823EFA91
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12C5D305D700
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E16292B2E;
	Mon, 13 Apr 2026 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aEdTJri3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B12C11CA;
	Mon, 13 Apr 2026 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098027; cv=none; b=JSW9fLStXaCiXsV2TQm2QGkML/0CpYC2zDGKTn1I/ErugCN2leJ/JZtM/L3hfFGfQBTZmEBr7iUpH5FGgdXEdww7eiw1zi+NY+w/yCjawXpkbQcWt7DUKMZN1sjFC1bKsYtrDpJcvFY13Bh0pyJzD+cgSppcCsJciP6GG36aFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098027; c=relaxed/simple;
	bh=+xc0ZimHQjuXEKbodKAIiNY6eQruA27n3A7wgntB5Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9kA6ehQynbUBu0IMXd4I1K0kb86+AZzOetB1q7D1bOnln+yq2waPF0rIedEy9xa5XQxrGqxoua0EpF1UQDAnyBZGtqQXXuYgle4U5iZiIslE+GSo7XKc92IMzzopb/Bp/9pI6PBvWafv/8D5O1obHu1pxL82kM6bcAoFI7kwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aEdTJri3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BACFC2BCAF;
	Mon, 13 Apr 2026 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098027;
	bh=+xc0ZimHQjuXEKbodKAIiNY6eQruA27n3A7wgntB5Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEdTJri3JydoOE8NiPqStBZ0agQ1jLZRaDU2M2kyjXCBhKzk6GTBOnNa+RFj6JOjG
	 E0AkyESPeJSvj/G7xioat/oX3RzntCVGd8+qliGjJl+ccqFbKLsI/rM94itYteB5SR
	 kEtF3A3Ob6Y96Krf7oGPYfd0njEVnllaoNlV/yAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Buerg <buermarc@googlemail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 364/570] sysctl: fix uninitialized variable in proc_do_large_bitmap
Date: Mon, 13 Apr 2026 17:58:15 +0200
Message-ID: <20260413155844.117370888@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236879-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,googlemail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 392823EFA91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Buerg <buermarc@googlemail.com>

[ Upstream commit f63a9df7e3f9f842945d292a19d9938924f066f9 ]

proc_do_large_bitmap() does not initialize variable c, which is expected
to be set to a trailing character by proc_get_long().

However, proc_get_long() only sets c when the input buffer contains a
trailing character after the parsed value.

If c is not initialized it may happen to contain a '-'. If this is the
case proc_do_large_bitmap() expects to be able to parse a second part of
the input buffer. If there is no second part an unjustified -EINVAL will
be returned.

Initialize c to 0 to prevent returning -EINVAL on valid input.

Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
Signed-off-by: Marc Buerg <buermarc@googlemail.com>
Reviewed-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index eaf9dd6a2f12f..ac16c3084c96c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1528,7 +1528,7 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 	unsigned long bitmap_len = table->maxlen;
 	unsigned long *bitmap = *(unsigned long **) table->data;
 	unsigned long *tmp_bitmap = NULL;
-	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;
+	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c = 0;
 
 	if (!bitmap || !bitmap_len || !left || (*ppos && !write)) {
 		*lenp = 0;
-- 
2.53.0




