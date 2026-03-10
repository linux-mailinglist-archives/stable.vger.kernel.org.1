Return-Path: <stable+bounces-224298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DH+E0QBsGm0eQIAu9opvQ
	(envelope-from <stable+bounces-224298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:32:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A3724AEFE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 125A930A5A33
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A819389456;
	Tue, 10 Mar 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn5gxTIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9653803CD;
	Tue, 10 Mar 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141994; cv=none; b=hBhe8iQ5j0dSGkVjNbab3bq/F+rJQ56p4DhiiyknU/VM34/gW14C+mtx+WAS8BHHE46/wpfvo/s+ody56YxZKcnbxMs5nD7F7SHGwttdpe6HmP9dm8XnVoN9sZE337TwOu7oUcy5njKkq1GByxInorEeImbZYJnNDSPf2ODSRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141994; c=relaxed/simple;
	bh=zrxJCGyelUJrPJxPPJSigI8lGGysfJLqhOiQpIebulE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdEeuq+YayyRG/ZibbJLyhFuEXazjKLFzQG1EyEM73cFu5Q1eoh+6muoiWJPcfpSFpLr9veOtdpBL5kMZ9Mgh9nDQ4iOvp9mXLMpxXjQMDSPSbCecfpD9dKhLy+r1r0xkUGHaTfl7RN5/cYBQ+gs0MpyoP5M7Jt9G0f45sVfaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn5gxTIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76472C2BC86;
	Tue, 10 Mar 2026 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141994;
	bh=zrxJCGyelUJrPJxPPJSigI8lGGysfJLqhOiQpIebulE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xn5gxTIQRyBpGPo3JXFalw1zdQ3e+0LVuzu2d/p1n2XU+k2IHvKsibyQvASE4tbq8
	 jRd3hunltnlMLwlcAV+cgJEsJgJ0j+lHkdUOBHu7/LlnHsVu+wXmap5uGT1aGOiXJc
	 /JedjFcKZv9GSscybZz6CLTa50kiHCw4wxNMCNxmrKzTqfwQdE65PZH/46xYI2Qx/6
	 JDGd1D7CzkCQFOuHDn+GIhMWCiQXfLTrCKLkdJ4qoTHp6t3HlVZ+VyWVk3vXDfyY/5
	 SGGofA7ISIWUsE5ovfUaU1zIIBFoFwahqImgoVQk1QIzHfg27Du67xfnQ1laFG2abf
	 L+w8GELKt1EuA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 119/314] PM: sleep: core: Avoid bit field races related to work_in_progress
Date: Tue, 10 Mar 2026 07:16:18 -0400
Message-ID: <1e64a97c21f72ec8d77bc4ea31233a9700961593.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05A3724AEFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224298-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Xuewen Yan <xuewen.yan@unisoc.com>

[ Upstream commit 0491f3f9f664e7e0131eb4d2a8b19c49562e5c64 ]

In all of the system suspend transition phases, the async processing of
a device may be carried out in parallel with power.work_in_progress
updates for the device's parent or suppliers and if it touches bit
fields from the same group (for example, power.must_resume or
power.wakeup_path), bit field corruption is possible.

To avoid that, turn work_in_progress in struct dev_pm_info into a proper
bool field and relocate it to save space.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.yan@unisoc.com/
Cc: All applicable <stable@vger.kernel.org>
[ rjw: Added subject and changelog ]
Link: https://patch.msgid.link/CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574c..12782f775a17e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -677,10 +677,10 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+	bool			work_in_progress;	/* Owned by the PM core */
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
-	bool			work_in_progress:1;	/* Owned by the PM core */
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
-- 
2.51.0


