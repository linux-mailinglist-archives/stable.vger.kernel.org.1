Return-Path: <stable+bounces-218100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNhDH6JQnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:30:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C583918EC77
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43CFB305F485
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20F253F11;
	Wed, 25 Feb 2026 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGPQdV6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41567242D9B;
	Wed, 25 Feb 2026 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982876; cv=none; b=jAEGwrk9N48PhHcYxb7kGLEcA9wGiNYbENKMMoHpIVFjl7J0AmGlwrsF1wPn67CK3lQg8RnFHwkShwR5ZGXlzO/M80JVGP7ToKf0ZVYKv2AJrsTXMSMmegE0oWGQ5CfHeKMNBmh1nurcXCDet2vOf0qQa1l+y2lwecAhHp4f1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982876; c=relaxed/simple;
	bh=OW8opBPZPvHMvw9jbElZHvfhcPUqvGya4KbKLP6hJ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADCACgDi3GcLn/UKNlMlemy+ayxS+xbATBfbtKDcAdR/P7KexSnkd9jlLsMhT8yqyJmHQkwqR1Uz61wJ3RDj9yF6Rh7wRWDa8VuIgpnmQFQEcQSP5Oo+IzFNmLvQbaZhSTl3XvWUEOGZnfreZpXma4gVnpAHx7jKKabRXyDI3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGPQdV6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020AEC116D0;
	Wed, 25 Feb 2026 01:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982876;
	bh=OW8opBPZPvHMvw9jbElZHvfhcPUqvGya4KbKLP6hJ5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGPQdV6MoYwpiqAOrw4D6ZPFzzeO/xBVJiwrMu2msshM/rvF0kQxbXSgfLteaEnu4
	 Ggrqu2nIAAjWNjPgMOry+0YH69l5fIRMFjNUWYJKEUl22lJsboWTg3EtnsW4UHT+jC
	 QoAj26ZwsC350/XO97PHyrQwCACRUdrhTu9Pdzuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 060/781] PM: wakeup: Handle empty list in wakeup_sources_walk_start()
Date: Tue, 24 Feb 2026 17:12:49 -0800
Message-ID: <20260225012401.178061889@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218100-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C583918EC77
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Wu <wusamuel@google.com>

[ Upstream commit 75ce02f4bc9a8b8350b6b1b01872467b0cc960cc ]

In the case of an empty wakeup_sources list, wakeup_sources_walk_start()
will return an invalid but non-NULL address. This also affects wrappers
of the aforementioned function, like for_each_wakeup_source().

Update wakeup_sources_walk_start() to return NULL in case of an empty
list.

Fixes: b4941adb24c0 ("PM: wakeup: Add routine to help fetch wakeup source object.")
Signed-off-by: Samuel Wu <wusamuel@google.com>
[ rjw: Subject and changelog edits ]
Link: https://patch.msgid.link/20260124012133.2451708-2-wusamuel@google.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/wakeup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 1e1a0e7eeac5f..e69033d16fba0 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
  */
 struct wakeup_source *wakeup_sources_walk_start(void)
 {
-	struct list_head *ws_head = &wakeup_sources;
-
-	return list_entry_rcu(ws_head->next, struct wakeup_source, entry);
+	return list_first_or_null_rcu(&wakeup_sources, struct wakeup_source, entry);
 }
 EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
 
-- 
2.51.0




