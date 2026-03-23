Return-Path: <stable+bounces-228301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP3FOhRNwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BBF2F4634
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD273050A2F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1EF3B0ADE;
	Mon, 23 Mar 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esNGEUN6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21173B0ACB;
	Mon, 23 Mar 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274739; cv=none; b=snQWwL6AdEh07I9WC/4DK52L2er/RPz4oeE15Q90AwhgEyfQeVPrO+pV7uZeLaHiUZGsfG4alnao+Zz/RkVBAuCkJvUZYwB6SN5MyPj4Xga9csBni+VZwEAeuyeks0e3HAsaz08FLbQhx0+1Ftkq2jPbb0kbm8Url2OnIHPqHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274739; c=relaxed/simple;
	bh=JZ4eR8diKEBgV1BckWVhCmfRqXODaVcSNNW0Z69m5fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBLwLcvL4YCl35MI+7vAXviFRQqmkcZ/JE7N9x3gL7COqsoWOzJDbW/gqxy/cb0jlpKMzFp/MQUmqDIw7MsxD91k0S/oFvVBq8ZsZFnHxBpJs8bCDQVkUKCl2JlRMjRvei9m+j87bIT3GHXF9EfM3Yvel11oyqfoQzr2Axp8W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esNGEUN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26288C4CEF7;
	Mon, 23 Mar 2026 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274739;
	bh=JZ4eR8diKEBgV1BckWVhCmfRqXODaVcSNNW0Z69m5fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esNGEUN6hCWhoEZkQfxeUf+UmrL5ltKcoQt3dpF6a3+A3sf87YtC0yZpEISVqkH9c
	 9w8zLhddIhzUpM6dXND7JZjFHLH61ItFPJKssMRJt8Rq7J1AcNl1DB/h0t7ZQj+g5x
	 ui983E+mRVcnDH0H1LfjWT0ZXyXwsRJB609Nulvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhanjun Dong <zhanjun.dong@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.18 094/212] drm/xe/guc: Ensure CT state transitions via STOP before DISABLED
Date: Mon, 23 Mar 2026 14:45:15 +0100
Message-ID: <20260323134506.748761296@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228301-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 26BBF2F4634
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhanjun Dong <zhanjun.dong@intel.com>

commit 7838dd8367419e9fc43b79c038321cb3c04de2a2 upstream.

The GuC CT state transition requires moving to the STOP state before
entering the DISABLED state. Update the driver teardown sequence to make
the proper state machine transitions.

Fixes: ee4b32220a6b ("drm/xe/guc: Add devm release action to safely tear down CT")
Cc: stable@vger.kernel.org
Signed-off-by: Zhanjun Dong <zhanjun.dong@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260310225039.1320161-6-zhanjun.dong@intel.com
(cherry picked from commit dace8cb0032f57ea67c87b3b92ad73c89dd2db44)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_guc_ct.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -266,6 +266,7 @@ static void guc_action_disable_ct(void *
 {
 	struct xe_guc_ct *ct = arg;
 
+	xe_guc_ct_stop(ct);
 	guc_ct_change_state(ct, XE_GUC_CT_STATE_DISABLED);
 }
 



