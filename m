Return-Path: <stable+bounces-224103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMfoMbX+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F4924A79A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0D6B30C7A1B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15CC38759A;
	Tue, 10 Mar 2026 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVIXhwtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5507386454;
	Tue, 10 Mar 2026 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141236; cv=none; b=efdNT5gS+Z1lzrAm3Ds9dOWSxAMY5Qd5oEwgbspsE20ku/JNEbQzVb9YxSr3XaFg/zXT4aMFpNcZrt7TSg2t/hqmqkKu9FcKQYuHhdXfFef7dm/7hCUngNk/LnkrMj8l2cn2xPnxwfj1cfqiyONWi9FaC+geGvdbTYm22axjiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141236; c=relaxed/simple;
	bh=L1F2gdsOdFlLRbaoWUQAWM+wjHuuHX1wOdOXUHDMEIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqydqKaJeQWFkLmhuFhOCTVDdEdESrqkWzc9/RtbNvtYQx44zSnDtZEtClMNcx5+kakUMtXTlWWW1fv9BtuYpB/PGM9GIilkpUBExN68NUwmU3Qjm/t8/0kQGN/iNC84tz8NOKwPoGKdRWrqjL/RqGMfyAGK1C0NXg3ZI2nmSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVIXhwtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2D8C19423;
	Tue, 10 Mar 2026 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141236;
	bh=L1F2gdsOdFlLRbaoWUQAWM+wjHuuHX1wOdOXUHDMEIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVIXhwtVvP5sEi4UTcnipVsaIhZ+GQDUSB25PT3r9N5UIg4zCVVks3vn7evtSUdwK
	 zQpMploKmIWK9vuYNLzDJ8oovOZAPEzBAeInXZs9uxvcP7RHwvSxGsGw9kQySS1a6z
	 yXAAmGFxOxbiEKoSQHr2bb5K/UqGLBXGi3YnrcjLZP760pWms6lN767ZXaJqXKPMqW
	 ZHbkTttVRTNcYF2G+XxE3fO0ImlT6V5wBldlT3urILZLlp7sLfHL8w8b5Gv7ET+vXa
	 iGPUindwHEfSEigV24s6df98kbAvWDIF8wtudNy7RguquH7jibnGFFVvJWNQxiaGFH
	 ShkswIYOQc9tA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 238/311] wifi: cw1200: Fix locking in error paths
Date: Tue, 10 Mar 2026 07:04:45 -0400
Message-ID: <e07bdaba7169bb1b16595a0232eb5a404f3de720.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46F4924A79A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224103-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,acm.org:email,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit d98c24617a831e92e7224a07dcaed2dd0b02af96 ]

cw1200_wow_suspend() must only return with priv->conf_mutex locked if it
returns zero. This mutex must be unlocked if an error is returned. Add
mutex_unlock() calls to the error paths from which that call is missing.
This has been detected by the Clang thread-safety analyzer.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260223220102.2158611-25-bart.vanassche@linux.dev
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/st/cw1200/pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/st/cw1200/pm.c b/drivers/net/wireless/st/cw1200/pm.c
index 2002e3f9fe45b..b656afe65db07 100644
--- a/drivers/net/wireless/st/cw1200/pm.c
+++ b/drivers/net/wireless/st/cw1200/pm.c
@@ -264,12 +264,14 @@ int cw1200_wow_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 		wiphy_err(priv->hw->wiphy,
 			  "PM request failed: %d. WoW is disabled.\n", ret);
 		cw1200_wow_resume(hw);
+		mutex_unlock(&priv->conf_mutex);
 		return -EBUSY;
 	}
 
 	/* Force resume if event is coming from the device. */
 	if (atomic_read(&priv->bh_rx)) {
 		cw1200_wow_resume(hw);
+		mutex_unlock(&priv->conf_mutex);
 		return -EAGAIN;
 	}
 
-- 
2.51.0


