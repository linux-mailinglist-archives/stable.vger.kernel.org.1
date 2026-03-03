Return-Path: <stable+bounces-222931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULYcFK4xp2kjfwAAu9opvQ
	(envelope-from <stable+bounces-222931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:08:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98E1F5AA8
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5423042B7B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D943CE485;
	Tue,  3 Mar 2026 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1D4OrrT"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298C3845AE
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564683; cv=none; b=W9MXh4otkWdPV57o9hCOU/eRcTDSDxOxtW86aiYAAbBG69JmyVXZr/EmrjWWs71cjjQWEf4Dkf+3Xi/P/mH1LPj47FJDqa496DiDpW2cCx3L630zF32k8ubzQqc2wiBIAyJyI+7I5jxuBEiAXiOoqJnS5B6G1wsjFMvdSHFaIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564683; c=relaxed/simple;
	bh=WhUagZ1UicyaFpNhua8urbyirAhseXZfR89wly+Nt6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km0MUK6cd6K+vXDx6GEJpNlhBB52+NNffhR2tBzygNi+Mw2Oz81mL8IWcCQl0GrdfCUYlJ8qelFk1+ufKg6LBWx8AsfC1ysFitsOgynV8vSKNLQZnEjrBZ5QCMg20T4FJ/8MEUDo5D1v2GJqEzl1V9ybNI7465QdzYxWU/0fC6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s1D4OrrT; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772564680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bYJxoGJiSgadF5JuKBSKfLsqU/3X+2Cl2fZ2lKuHEQ=;
	b=s1D4OrrTwU9i2oEBicHGxlYuSQO+Jqn+FHKbmV72z6ui6q6lUNfJSnS0xxf4eDvWBSRSCw
	+PtOWeLF8GH8ZC9WR65nngvkvlhMB8TxF3ZTFNinZGskWp0rYcEy43Dt1uRFf0YhRT2mPp
	I4h1loe8kIoa+w322SVLwy3jnUaIvpY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nvmet-auth: Don't log DHCHAP keys in nvmet_setup_auth()
Date: Tue,  3 Mar 2026 20:03:50 +0100
Message-ID: <20260303190350.78705-4-thorsten.blum@linux.dev>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9F98E1F5AA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222931-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When debug logging is enabled, nvmet_setup_auth() logs the host and
controller DHCHAP key bytes. Remove the keys from debug logs to avoid
exposing key material.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/nvme/target/auth.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 2eadeb7e06f2..f24add0bb86f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -199,10 +199,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		ctrl->host_key = NULL;
 		goto out_free_hash;
 	}
-	pr_debug("%s: using hash %s key %*ph\n", __func__,
+	pr_debug("%s: using hash %s\n", __func__,
 		 ctrl->host_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
-		 (int)ctrl->host_key->len, ctrl->host_key->key);
+		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none");
 
 	nvme_auth_free_key(ctrl->ctrl_key);
 	if (!host->dhchap_ctrl_secret) {
@@ -217,10 +216,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		ctrl->ctrl_key = NULL;
 		goto out_free_hash;
 	}
-	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
+	pr_debug("%s: using ctrl hash %s\n", __func__,
 		 ctrl->ctrl_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
-		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
+		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none");
 
 out_free_hash:
 	if (ret) {
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


