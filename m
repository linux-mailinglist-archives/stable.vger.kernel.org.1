Return-Path: <stable+bounces-246157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEtZOG9sA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C101526D20
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C28A6314566D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535083955D3;
	Tue, 12 May 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRqtUXH0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C053DD85D;
	Tue, 12 May 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608505; cv=none; b=fBjIu1/igENE8Qjn4MzFTZNDGpcHQGCF3jAto//pkw3JgIIUwUTo4LJKGAUzH4hU978lKq8wMbvoLLuQzq0qn5OL8KjStMzllUhz3JMreFuf5BmtF3imyugmvLBph26yM4BMd9TOFHMRMuP3IgGCau3MiId9NbDAyaSp+Ox7uD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608505; c=relaxed/simple;
	bh=19ZGOYFFI43BFXUUEWdbn0yxyPZ4g4ZjP9b6PN/9SQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tncEt1BEnUeQDWcavHULRaNUZHjYX0TdUkPXxxJw9jS2L2kqG8oO3c6ub17vbKsViZZ5W0mDm7A0Xmb9RNQWt6j6gaDjUrFCKDLM/XzlQFo6pbq90x8of5tbAKLK3k9/rUUs89mHGn7papYpRMkGGsxGM1Rqq0LY09b2hXZ4ypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRqtUXH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C21C2BCB0;
	Tue, 12 May 2026 17:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608505;
	bh=19ZGOYFFI43BFXUUEWdbn0yxyPZ4g4ZjP9b6PN/9SQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRqtUXH0u0Sxc/pxf4C64Y8Wqoa737YxbICNelj+9qqlX8Xrp15mxQyDkrAfK0/tT
	 pweShvZZcbtiFTXmhcn6fo7oU12JwKs/ur6PRKC5GHwvsC0V87mz8M9w2bzI8cmE3O
	 rd87TwBtqZKRwJL3wZcg1+zmvw+N9xRJNbYTHRMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 6.18 105/270] platform/chrome: cros_ec_typec: Init mutex in Thunderbolt registration
Date: Tue, 12 May 2026 19:38:26 +0200
Message-ID: <20260512173940.669589128@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7C101526D20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246157-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,chromium.org:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tzung-Bi Shih <tzungbi@kernel.org>

commit 525cb7ba6661074c1c5cc3772bccc6afab6791ef upstream.

cros_typec_register_thunderbolt() missed initializing the `adata->lock`
mutex.  This leads to a NULL dereference when the mutex is later
acquired (e.g. in cros_typec_altmode_work()).

Initialize the mutex in cros_typec_register_thunderbolt() to fix the
issue.

Cc: stable@vger.kernel.org
Fixes: 3b00be26b16a ("platform/chrome: cros_ec_typec: Thunderbolt support")
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Link: https://lore.kernel.org/r/20260505053403.3335740-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_typec_altmode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -359,6 +359,7 @@ cros_typec_register_thunderbolt(struct c
 	}
 
 	INIT_WORK(&adata->work, cros_typec_altmode_work);
+	mutex_init(&adata->lock);
 	adata->alt = alt;
 	adata->port = port;
 	adata->ap_mode_entry = true;



