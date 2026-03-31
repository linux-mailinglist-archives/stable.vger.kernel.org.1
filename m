Return-Path: <stable+bounces-232360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMg+Hk4DzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:24:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7900336EA16
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77CD830FF7BA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08904301471;
	Tue, 31 Mar 2026 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOoT9MZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBB2FC89C;
	Tue, 31 Mar 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976546; cv=none; b=QAPXabXZoHxIKHHtQc7TNwwFL1gX615lOmFYr21Lwt+7+kujwKgx08t9azjtzaS77DfTB3wDEOm4OFcZCf3IH7Fx0tUK+eVkMEelePvPhUkl51uv67Whc2m8+H+mhUesC4B/cWLvia/H/tUVLvMcwehtVNzvd9G7Db72nnCYt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976546; c=relaxed/simple;
	bh=C115/y+XLQ7MR1tSB3xvAhaQYhj7Mv5UkQ0fOtgBeXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL5JBfJz5GyS7fV6mxOcBMqqHsZ1oBF26ldPLUqHDQXwkiW8ZviNO9MHI1jXtIXu27+nOBOx/T3Xg7UJfA/27l4F+Z0gmqGAbob+SFa9JOZvrR9XRgkwrPAOqsFF9n3bfP643ngHVA8yN/AcRbhTR1UyUuF26Vs9LD3rR+8NJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOoT9MZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D3FC19423;
	Tue, 31 Mar 2026 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976546;
	bh=C115/y+XLQ7MR1tSB3xvAhaQYhj7Mv5UkQ0fOtgBeXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOoT9MZ63jhPytdVDcHu9vUvZGyMc8Z/ZR6jq/a2RSZAlHVefRYww4lAPoi9/PARb
	 XiatfecZUYpodVc/ubP+S0+SRYDjQRlru55aIzvjUlCDH+pUWP7lAbyFeL+EvpVOU4
	 cYjZq30Qy9usZlYCZeOOdcwTzMtLfxjbuG3arDmU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 101/309] platform/x86: lenovo: wmi-gamezone: Drop gz_chain_head
Date: Tue, 31 Mar 2026 18:20:04 +0200
Message-ID: <20260331161757.205877963@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232360-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,squebb.ca:email]
X-Rspamd-Queue-Id: 7900336EA16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 5a3955f3602950d1888df743a5b1889e43b5cb60 ]

The gz_chain_head variable has been unused since the driver's initial
addition to the tree. Its use was eliminated between v3 and v4 during
development but due to the reference of gz_chain_head's wait_list
member, the compiler could not warn that it was unused.

After a (tip) commit ("locking/rwsem: Remove the list_head from struct
rw_semaphore"), which removed a reference to the variable passed to
__RWSEM_INITIALIZER(), certain configurations show an unused variable
warning from the Lenovo wmi-gamezone driver:

  drivers/platform/x86/lenovo/wmi-gamezone.c:34:31: warning: 'gz_chain_head' defined but not used [-Wunused-variable]
     34 | static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
        |                               ^~~~~~~~~~~~~
  include/linux/notifier.h:119:39: note: in definition of macro 'BLOCKING_NOTIFIER_HEAD'
    119 |         struct blocking_notifier_head name =                    \
        |                                       ^~~~

Remove the variable to prevent the warning from showing up.

Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://patch.msgid.link/20260313-lenovo-wmi-gamezone-remove-gz_chain_head-v1-1-ce5231f0c6fa@kernel.org
[ij: reorganized the changelog]
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo/wmi-gamezone.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index b26806b37d960..baf1238b4d1d9 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -31,8 +31,6 @@
 #define LWMI_GZ_METHOD_ID_SMARTFAN_SET 44
 #define LWMI_GZ_METHOD_ID_SMARTFAN_GET 45
 
-static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
-
 struct lwmi_gz_priv {
 	enum thermal_mode current_mode;
 	struct notifier_block event_nb;
-- 
2.51.0




