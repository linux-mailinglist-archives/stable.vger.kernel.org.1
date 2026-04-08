Return-Path: <stable+bounces-234361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIlkL4Cd1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:25:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D94403C0A7D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95E1B300FEF2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA919324B1F;
	Wed,  8 Apr 2026 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z9A4ys4M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38A3ACF11;
	Wed,  8 Apr 2026 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672659; cv=none; b=XMeSJP3BKNhNSXPu8q+quyOSe44JpfKj0owVcaN18UYUby2UKP9OKVWSqaqoII4FB66r/Y+dQo1sUEmchfUpEdU3K5D/+GfMQJALoCpjqDqjsTqmZ9TXrMAOKlW/4CMXdQ1MBQZ+sl1foK/Kqp4HcYIrpEoq55JK2aF5mCkxQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672659; c=relaxed/simple;
	bh=k1q0xvXLzokHrNrhVNDy+qAMq73drfmfGi7EQVwaSxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6okB2/0k60u7z2NHuJYeQUWf1PUJIzrW15NG5SDLUD8SpcvMVaBWY18dkfPMEm/1oveglK5ftXiN7LC7OFYfL323s6mUYGGM+gdoVlqOoKBRbhtNKTbRK1IAZQJw7rA0kE/Q8BavbEJyVRG9NvJ9+iTFSvDTz7I+P0qTz4EKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z9A4ys4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBEBC19421;
	Wed,  8 Apr 2026 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672659;
	bh=k1q0xvXLzokHrNrhVNDy+qAMq73drfmfGi7EQVwaSxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z9A4ys4MHNzKOngR2Oe6D6IG9Qkse90BmUEeLL1X87uPmdXIMdzN8fp7g9YNSyVNa
	 Uib3cNCLPxuHAA4DcKY1Ik5XOsI31Xt3ffj4GHs8O9IxATuGLKMoKwZgLT0Mutk8ej
	 KtdR2ANVqGfAaYJNUlqEV4oCiOaKRXsPMReGz9Ms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.6 091/160] Input: synaptics-rmi4 - fix a locking bug in an error path
Date: Wed,  8 Apr 2026 20:02:58 +0200
Message-ID: <20260408175916.591927733@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234361-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,acm.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D94403C0A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit 7adaaee5edd35a423ae199c41b86bd1ed60ed483 upstream.

Lock f54->data_mutex when entering the function statement since jumping
to the 'error' label when checking report_size fails causes that mutex
to be unlocked.

This bug has been detected by the Clang thread-safety checker.

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260223215118.2154194-16-bvanassche@acm.org
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_f54.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -540,6 +540,8 @@ static void rmi_f54_work(struct work_str
 	int error;
 	int i;
 
+	mutex_lock(&f54->data_mutex);
+
 	report_size = rmi_f54_get_report_size(f54);
 	if (report_size == 0) {
 		dev_err(&fn->dev, "Bad report size, report type=%d\n",
@@ -548,8 +550,6 @@ static void rmi_f54_work(struct work_str
 		goto error;     /* retry won't help */
 	}
 
-	mutex_lock(&f54->data_mutex);
-
 	/*
 	 * Need to check if command has completed.
 	 * If not try again later.



