Return-Path: <stable+bounces-250193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB1zDacNDmqe5wUAu9opvQ
	(envelope-from <stable+bounces-250193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:38:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E6598862
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 847CC33542EE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46837269C;
	Wed, 20 May 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oavwk/RI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7413A4526;
	Wed, 20 May 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294789; cv=none; b=lLbhSBk313VFT0i5jQGyG9LFUby3HIBNzQtwqyrLcfdY90Wxf5yg0fy1u5uu3a6nFrdogNXHwzikFFUXCOwpVIldLDckUfEkJBiT5as6Fw1nWQcidS9Ynf0pNa7W12cBYdeS6TnUxNNAeGKaPV8ukV8yHVYyL6r0s0pgsy7xUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294789; c=relaxed/simple;
	bh=r43ULdfJQ5x6SLu0yq29OFx9vv4lCeQiPntpTlm/M0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcnuJXFi1ojpHP5oIQQgVWLp96XwbRCL+vaQCZ7xYI2GgxhCO92oc6vgtqWo79RzWkGB+sR8lrwyh8r2Zd5znlV2w7eqNY+3eQpwmHRXvyzObAFCDvPry9qZ1rDg7jwOtS0ptL7D3D+DzHsJIKaDr/AecesMiH7PQj+JEVfV1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oavwk/RI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CED1F000E9;
	Wed, 20 May 2026 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294787;
	bh=k4Yhk5AkPlvOEGwyWKo0MbLhuYQ+suV+HxIM70+hRg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oavwk/RISkPzjBUe6m7pgFW+HEFsBIUuzr/4a7OpcomTg/ueNNYXwjUCD84jF+li+
	 yoZWAzVB1aEu9CFA2s/22g5zPG4NO6Wy8QwCuoAMnb/BlgMvnituFkH19wAjqATHoD
	 9kGeJvCS+QDsVaz+AiWOmX0GVduVJvNNlz36arBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Duoming Zhou <duoming@zju.edu.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0122/1146] wifi: mt76: mt7915: fix use-after-free bugs in mt7915_mac_dump_work()
Date: Wed, 20 May 2026 18:06:12 +0200
Message-ID: <20260520162151.092910360@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250193-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zju.edu.cn:email,nbd.name:email]
X-Rspamd-Queue-Id: 284E6598862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 1146d0946b5358fad24812bd39d68f31cd40cc34 ]

When the mt7915 pci chip is detaching, the mt7915_crash_data is
released in mt7915_coredump_unregister(). However, the work item
dump_work may still be running or pending, leading to UAF bugs
when the already freed crash_data is dereferenced again in
mt7915_mac_dump_work().

The race condition can occur as follows:

CPU 0 (removal path)               | CPU 1 (workqueue)
mt7915_pci_remove()                | mt7915_sys_recovery_set()
 mt7915_unregister_device()        |  mt7915_reset()
  mt7915_coredump_unregister()     |   queue_work()
   vfree(dev->coredump.crash_data) | mt7915_mac_dump_work()
                                   |  crash_data-> // UAF

Fix this by ensuring dump_work is properly canceled before
the crash_data is deallocated. Add cancel_work_sync() in
mt7915_unregister_device() to synchronize with any pending
or executing dump work.

Fixes: 4dbcb9125cc3 ("wifi: mt76: mt7915: enable coredump support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Link: https://patch.msgid.link/20260130145759.84272-1-duoming@zju.edu.cn
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 22443cbc74adc..250c2d2479b0c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1294,6 +1294,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 void mt7915_unregister_device(struct mt7915_dev *dev)
 {
+	cancel_work_sync(&dev->dump_work);
 	mt7915_unregister_ext_phy(dev);
 	mt7915_coredump_unregister(dev);
 	mt7915_unregister_thermal(&dev->phy);
-- 
2.53.0




