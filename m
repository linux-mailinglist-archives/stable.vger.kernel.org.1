Return-Path: <stable+bounces-243782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MhRL4ix+GlizAIAu9opvQ
	(envelope-from <stable+bounces-243782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:47:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBC54C0035
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AA8C304725C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB9E3E1232;
	Mon,  4 May 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wn9hY/mb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588D3D8129;
	Mon,  4 May 2026 14:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904764; cv=none; b=dhlh9Yp37bMjmWZ1+tnaw1thHkzXzb5n2SK2YNWcKkbk+UPAtsTvG2BMoTY8IlXUDfBfPzFJENkOHmR2D1BiMlDvFIYyp4/cUC+1/9rzZ6kTnBWBm/w7vn8FwcgRB8K0SSAehujVrwBtHqsHZTElvBMvcoBMDNtauyxJxjeQHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904764; c=relaxed/simple;
	bh=dfVIj/Rny9Y/RWbk5gYnTFYemo7zUl/yZiyVXirIhpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaLQwFPc9O3vtJpVlQoaZU57aNiPf5Mlcb3+OUiKUbS91Nfabqhynf2KhseB9vSHuW3YFxMNiHzeSMNflmcE4H15Hz8eVCqboqa6IN7bN30QUpvRdDDHxcXVm+j42+e5moGWaw0oT9E7XFbnarXqrnelxYnm/z/SgqOYE+KEcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wn9hY/mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F8C2BCB8;
	Mon,  4 May 2026 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904764;
	bh=dfVIj/Rny9Y/RWbk5gYnTFYemo7zUl/yZiyVXirIhpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wn9hY/mbRq5LATTWtBAUjH2KUTmbL2dI2N6loLJZX0mjVk4xBQ9ERpKKPKsTxD57B
	 sX7Qa/Ua2IeebmL2adoQHfdQgHzdntQk8/JtFpyHcmJGD6A/hfEs14mp8Hy98OW0jU
	 wZ6+oDRgvefT2zXNNQOnlxzy6qW09n3LFt5YbsjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.12 164/215] dm mirror: fix integer overflow in create_dirty_log()
Date: Mon,  4 May 2026 15:53:03 +0200
Message-ID: <20260504135136.167301937@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: ACBC54C0035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-243782-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit 4c788c6f921b22f9b6c3f316c4a071c05683e7de upstream.

The argument count calculation in create_dirty_log() performs
`*args_used = 2 + param_count` before validating against argc. When a
user provides a param_count close to UINT_MAX via the device mapper
table string, this unsigned addition wraps around to a small value,
causing the subsequent `argc < *args_used` check to be bypassed.

The overflowed param_count is then passed as argc to dm_dirty_log_create(),
where it can cause out-of-bounds reads on the argv array.

Fix by comparing param_count against argc - 2 before performing the
addition, following the same pattern used by parse_features() in the
same file. Since argc >= 2 is already guaranteed, the subtraction is
safe.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid1.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -993,13 +993,13 @@ static struct dm_dirty_log *create_dirty
 		return NULL;
 	}
 
-	*args_used = 2 + param_count;
-
-	if (argc < *args_used) {
+	if (param_count > argc - 2) {
 		ti->error = "Insufficient mirror log arguments";
 		return NULL;
 	}
 
+	*args_used = 2 + param_count;
+
 	dl = dm_dirty_log_create(argv[0], ti, mirror_flush, param_count,
 				 argv + 2);
 	if (!dl) {



