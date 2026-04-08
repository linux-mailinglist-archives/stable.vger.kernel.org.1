Return-Path: <stable+bounces-234394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEb0K0ie1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:28:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5851D3C0C87
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D0C83018294
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166B3D34AB;
	Wed,  8 Apr 2026 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aCSkSQPz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F4B67E;
	Wed,  8 Apr 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672744; cv=none; b=lpbmgvG4zN9LCwoePHRJOWIe2xapFASTZXOG+NSnyMNpgUp1gHKge9dDOty9G4ZnzuhWoRbf93AFF0U7V6Q6Hja0no3bc60LARZIxX7fPcAYdaK/QxQHsbH6xPhnARzUegc9uM8qpKY3uxcX2PjXul5kU5Est2q+uhz9HOln0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672744; c=relaxed/simple;
	bh=FBjDF6DZnREQIIjLUUDQ6JsFrgOuyu1ZU3517QmsVvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxRSZtNrbUYN8v98Hv9H2ggTVFdfCYoEcqs4VQvsrDSDsXlwl9BCaOVgz6/Lulfu3RDnF4J/h3ZQzNeE88GZuqrc1wux7KmlxcFaM1qQBgoNYjQuzYzIp3K3gP6EGZ/OZKEDBgm1pIloFyem8PlfUwgLrH5yr4A9xdzHDAYqwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aCSkSQPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4B0C19421;
	Wed,  8 Apr 2026 18:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672744;
	bh=FBjDF6DZnREQIIjLUUDQ6JsFrgOuyu1ZU3517QmsVvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCSkSQPzxyUHcug1MXs+AUDFxWXzl9CRqodlVLx5+7L7CFo5Aw+ZUfd+3A0LH9V47
	 rjRx2S7RxNZ3JH3dh+qfQ6/meiO0Q0a8u/qSf4zQ2WckJ+1rptsr6wtMzjK5FWDPwF
	 fRz8VOv5Y2HO7u72B9vbxAiD1F0kAftOXd2nbSMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.6 125/160] counter: rz-mtu3-cnt: prevent counter from being toggled multiple times
Date: Wed,  8 Apr 2026 20:03:32 +0200
Message-ID: <20260408175917.858033663@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234394-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,renesas.com:email]
X-Rspamd-Queue-Id: 5851D3C0C87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 67c3f99bed6f422ba343d2b70a2eeeccdfd91bef upstream.

Runtime PM counter is incremented / decremented each time the sysfs
enable file is written to.

If user writes 0 to the sysfs enable file multiple times, runtime PM
usage count underflows, generating the following message.

rz-mtu3-counter rz-mtu3-counter.0: Runtime PM usage count underflow!

At the same time, hardware registers end up being accessed with clocks
off in rz_mtu3_terminate_counter() to disable an already disabled
channel.

If user writes 1 to the sysfs enable file multiple times, runtime PM
usage count will be incremented each time, requiring the same number of
0 writes to get it back to 0.

If user writes 0 to the sysfs enable file while PWM is in progress, PWM
is stopped without counter being the owner of the underlying MTU3
channel.

Check against the cached count_is_enabled value and exit if the user
is trying to set the same enable value.

Cc: stable@vger.kernel.org
Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://lore.kernel.org/r/20260130122353.2263273-5-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/counter/rz-mtu3-cnt.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -499,21 +499,25 @@ static int rz_mtu3_count_enable_write(st
 	struct rz_mtu3_cnt *const priv = counter_priv(counter);
 	int ret = 0;
 
+	mutex_lock(&priv->lock);
+
+	if (priv->count_is_enabled[count->id] == enable)
+		goto exit;
+
 	if (enable) {
-		mutex_lock(&priv->lock);
 		pm_runtime_get_sync(ch->dev);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
-		mutex_unlock(&priv->lock);
 	} else {
-		mutex_lock(&priv->lock);
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
 		pm_runtime_put(ch->dev);
-		mutex_unlock(&priv->lock);
 	}
 
+exit:
+	mutex_unlock(&priv->lock);
+
 	return ret;
 }
 



