Return-Path: <stable+bounces-257664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIWTOI4eG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:29:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900B60FCB6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3388B30B744B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB22332EA7;
	Sat, 30 May 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/Kg2hbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850AA3242D7;
	Sat, 30 May 2026 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161759; cv=none; b=dQsyZ29OtBw+HhFkUmUioO/xfsjGMSesdBYw+qBS2LgQMydvHD0wd1vo/tprGQ9iKcKBNThHURDSfrZNr8Y0Ad67v25ZPJIzII9LZUxXf/JFzO1D9DzMEqbjYMKjodiFiX+RuuKsXMLbSpC5azjh6Ld9m5IWWYyN/ybsZhldrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161759; c=relaxed/simple;
	bh=S+d6QV1Kg8Mg8VxtLE9DNwWy6PFK9h01aZt0De2S6FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u33rHA+NuTZh3l9J+YzAcnVwMbpKJeNf5KGQQD4vH149YqSFIBxeuZkiV0z2VKvCMjFlTTI5sOYiwHTOJ6HOb+U706OHZVjnNcwydlR7S1am6p9w8PiE47i3kJCJZo0Hs0yeC6TdywIB7wQB4JRqjc9+RQO8TlD1xyIJ87fsBEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/Kg2hbJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F2F1F00893;
	Sat, 30 May 2026 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161758;
	bh=n6DU13sWffU616/kFSpA1GXHp9qswuzcVcwx+cOUs/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/Kg2hbJpHBRLvuNuLoFJaHk2fnfkG1ZhwTdcDpQ93eaBdC5ko76VDYyCRZy9iIUv
	 rorJAgULR44Pxch0zGehxnKDjegZJ7YHIohZchLmgIDmFPheVIXTG9E628Aq43XX5T
	 5gJg87pHFQmFQGiNv3tKMoMEYpvJYc0NhG0BkShc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdulkader Alrezej <alrazj.abdulkader@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 718/969] net: dsa: realtek: rtl8365mb: fix mode mask calculation
Date: Sat, 30 May 2026 18:04:02 +0200
Message-ID: <20260530160320.365174764@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257664-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,yahoo.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6900B60FCB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>

[ Upstream commit 0c078021d3861966614d5e594ee03587f0c9e74d ]

The RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK macro was shifting
the 4-bit mask (0xF) by only (_extint % 2) bits instead of
(_extint % 2) * 4. This caused the mask to overlap with the adjacent
nibble when configuring odd-numbered external interfaces, selecting
the wrong bits entirely.

Align the shift calculation with the existing ...MODE_OFFSET macro.

Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
Signed-off-by: Abdulkader Alrezej <alrazj.abdulkader@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Link: https://patch.msgid.link/400a6387-a444-4576-af6d-26be5410bce3@yahoo.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index c22e69ab0deb1..97673ccb7ac79 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -212,7 +212,7 @@
 		 (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_SELECT_REG1 : \
 		 0x0)
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(_extint) \
-		(0xF << (((_extint) % 2)))
+		(0xF << (((_extint) % 2) * 4))
 #define   RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(_extint) \
 		(((_extint) % 2) * 4)
 
-- 
2.53.0




