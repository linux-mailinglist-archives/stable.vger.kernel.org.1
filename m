Return-Path: <stable+bounces-250890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN2OBj7wDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C359F593E95
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD44E309B745
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006A3ED5C8;
	Wed, 20 May 2026 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVnjBon3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5E3F889E;
	Wed, 20 May 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296576; cv=none; b=F7rOn7APGMN/ayellwCYd6szWfXWs6H4vBC9TU7K2BPIP098aFRehbUB8yS6eOQwmTBkDBp+iT+pJsgXLqtBimdJsmxGamdP66wR4Ah4J+JuY4tewZsnY9rfur95R1M+wu8rUj2dOAAKv8KbZRGHTccXoZxzzsZ2f5OwpWOM3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296576; c=relaxed/simple;
	bh=EW4KSIv2c1uNZAL4zJYiuJyQD0njZMAmjme3/T2mhQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDdTZ41Ab0gUGEv4cH2Cgt3tDG3i1YexzrJgHrgOwZ3WFEb2093f0YkmCUrUNAf3wB7ogcJokxKKW069CorEDEGKs0LNvVcdOSVNoacZ7TgR2/3jGS4HimlUA3f1ITox9AMCXN6gqzK0tvDZZN3a4UP+y/Dbmz7zFyZI4351ej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVnjBon3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D628F1F000E9;
	Wed, 20 May 2026 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296572;
	bh=dSJ6mtodUs2v4MveTX5gc6zJ0jfaUNLgKx0zt4mfXrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVnjBon32DXgHSnsF2hUDwmY+ySp4DNMkS20+h/h/XAK0FToCVNY/QUDvS/4LLTM5
	 hH+QyXHPDh8AAOBtXEhIjWdJfMKek0JTrkQ6j+JBIdAocrMHman9lU6lssdJ8zlXTK
	 B3/xJa5Vs8J+l729EtFwDM6X3EbLSgueYZvt6vUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0850/1146] net: mana: Init link_change_work before potential error paths in probe
Date: Wed, 20 May 2026 18:18:20 +0200
Message-ID: <20260520162207.473645585@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250890-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C359F593E95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

[ Upstream commit cb4a90744bcd1adf12f0d0c7c4f0dd2647444ec5 ]

Move INIT_WORK(link_change_work) to right after the mana_context
allocation, before any error path that could reach mana_remove().

Previously, if mana_create_eq() or mana_query_device_cfg() failed,
mana_probe() would jump to the error path which calls mana_remove().
mana_remove() unconditionally calls disable_work_sync(link_change_work),
but the work struct had not been initialized yet. This can trigger
CONFIG_DEBUG_OBJECTS_WORK enabled.

Fixes: 54133f9b4b53 ("net: mana: Support HW link state events")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Link: https://patch.msgid.link/20260420124741.1056179-2-ernis@linux.microsoft.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 2ff19e1938f49..2b3dd326a8e15 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3594,6 +3594,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 		ac->gdma_dev = gd;
 		gd->driver_data = ac;
+
+		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	}
 
 	err = mana_create_eq(ac);
@@ -3611,8 +3613,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	if (!resuming) {
 		ac->num_ports = num_ports;
-
-		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	} else {
 		if (ac->num_ports != num_ports) {
 			dev_err(dev, "The number of vPorts changed: %d->%d\n",
-- 
2.53.0




