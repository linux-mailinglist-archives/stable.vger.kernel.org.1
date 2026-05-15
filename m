Return-Path: <stable+bounces-248176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFbyOIdIB2rUwQIAu9opvQ
	(envelope-from <stable+bounces-248176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:23:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B73EF553235
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AE7C310CB5A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A993E0092;
	Fri, 15 May 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rXV2zVDk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD4D2EAB82;
	Fri, 15 May 2026 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861067; cv=none; b=e9WMn4B6wXEDYsFkUCSZdMqDrgeWfjnlsSoEzVWrEICiXOlqrN9zEmFV76L1SjgU6HvTRj2CEfYWuPGj3P0034Vsg9/n+WKntI0Df2a7AdINMYK3sOcS1/QMxFC2lUFcecHfmYr77ts3kaaO7cem/WZZWQYuZnjbZVsFMCVgBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861067; c=relaxed/simple;
	bh=wzcw9C14vu52FEnDRwqEho1wA61s8SDmCUnL5+SLEfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXeLg8IbY0SquNHA4ySvnqIXuLxD2ovvgqYFsuUdkD90okv8gyn9Xy9m32oJs4Ssad0WER6W2YQYIbYRL9UW/nbTjuqPvCR/kYb9Uayx9eFL8cEdHvSIXHNQCns0Hl9wsOcphG58+mO/EjaSgGvNiHbMPNtgAcj6kee29SVSgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rXV2zVDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DF2C2BCB0;
	Fri, 15 May 2026 16:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861067;
	bh=wzcw9C14vu52FEnDRwqEho1wA61s8SDmCUnL5+SLEfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXV2zVDkECE8YEH0x1qII5J/sHiWccNWhgLUjFKPhvsBCQTeHfGOVD2ih8LTNO4RG
	 BgrTj36i3x0d2h3KL5/b82K6mn7o2ZtN7GSLJd7t/9b8nspMLACpe29EZqH08/tGOt
	 ONfsFOBrhbreHIVGg4sj5b9PFkdZqVKfCu9o9Qgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quan Zhou <quan.zhou@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 6.6 185/474] wifi: mt76: mt7921: fix ROC abort flow interruption in mt7921_roc_work
Date: Fri, 15 May 2026 17:44:54 +0200
Message-ID: <20260515154719.026576141@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B73EF553235
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248176-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,nbd.name:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quan Zhou <quan.zhou@mediatek.com>

commit fdfa39f9f4fbae532b162da913a67b2410caf38f upstream.

The mt7921_set_roc API may be executed concurrently with mt7921_roc_work,
specifically between the following code paths:

- The check and clear of MT76_STATE_ROC in mt7921_roc_work:
    if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
        return;

- The execution of ieee80211_iterate_active_interfaces.

This race condition can interrupt the ROC abort flow, resulting in
the ROC process failing to abort as expected.

To address this defect, the modification of MT76_STATE_ROC is now
protected by mt792x_mutex_acquire(phy->dev). This ensures that
changes to the ROC state are properly synchronized, preventing
race conditions and ensuring the ROC abort flow is not interrupted.

Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel support")
Cc: stable@vger.kernel.org
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/2568ece8b557e5dda79391414c834ef3233049b6.1769133724.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -361,10 +361,11 @@ void mt7921_roc_work(struct work_struct
 	phy = (struct mt792x_phy *)container_of(work, struct mt792x_phy,
 						roc_work);
 
-	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		return;
-
 	mt792x_mutex_acquire(phy->dev);
+	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state)) {
+		mt792x_mutex_release(phy->dev);
+		return;
+	}
 	ieee80211_iterate_active_interfaces(phy->mt76->hw,
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_roc_iter, phy);



