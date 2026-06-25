Return-Path: <stable+bounces-268365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NXwILKgXPWquwwgAu9opvQ
	(envelope-from <stable+bounces-268365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:57:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D526C5504
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:57:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=wU5c1pbx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268365-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268365-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yandex.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0E93047438
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C373D3D10;
	Thu, 25 Jun 2026 11:49:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565C184;
	Thu, 25 Jun 2026 11:49:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782388159; cv=none; b=u8c1/OPJ6tAi5g9EiekCUUx+1Rj4RHTA5icSXd6aNHZVyv5NB63foYx+zVMqJqEAVAkWM0QNU/pPI+NaWDtan5Rjsj2RMPvwXBotftVX2I5N+O9Ga6DPf3m1OsmOVgcRexvLIF8sU088gQ/isyuKhF6dUc+3OsKsPfMLvXk6eo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782388159; c=relaxed/simple;
	bh=siMqfGA2LbcLpc8TVJBf9szt0ISO8uooGPF6kp3XeSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFz4zPfgFWuuz62siK5JybatSFrxuc0I/e/TUFHhV+BfyHmcaPO/DKF4UDooUTY4/fMmEwajZrRAgzFlv4VD0WPEyA7au4/MkSeap7YCuRIUxYc7kKjEilVoZGbu27KdKsieK9J7sgJfUqNdlhlFi5epLoht0vgkAQ5RauBuvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=wU5c1pbx; arc=none smtp.client-ip=178.154.239.85
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id BF39EC0303;
	Thu, 25 Jun 2026 14:49:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp) with ESMTPSA id imX0h9Zd7a60-9VPCYWd1;
	Thu, 25 Jun 2026 14:49:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782388146; bh=N3iJX4b7hiSFwQlA4tOHWUsCIZUNpe0ZD60sev6y8NA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=wU5c1pbxBjWOZrMRoEOGDGa8Hcqtk0iEH/Q/6NO75zGGCmSHaVg7badtMMUluXY0S
	 NEjxiyR4gqM5trvVOhq8JCT/AbNNE7QRPbw9ZKZUOQMwtS4AS50lT3/zhr2DwPId6h
	 tcVpKCdlg3c1B1WtKKclbTX0jJD35z8upiMinaHI=
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	idosch@nvidia.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] mlxsw: spectrum_acl_erp: Fix const qualifier of delta_clear()
Date: Thu, 25 Jun 2026 14:48:31 +0300
Message-ID: <20260625114831.17386-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [10.34 / 15.00];
	URIBL_BLACK(7.50)[linuxtesting.org:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268365-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[yandex.ru];
	R_DKIM_ALLOW(0.00)[yandex.ru:s=mail];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:idosch@nvidia.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[yandex.ru,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,vger.kernel.org,linuxtesting.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[yandex.ru,none];
	DKIM_TRACE(0.00)[yandex.ru:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxtesting.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38D526C5504
X-Spam: Yes

mlxsw_sp_acl_erp_delta_clear() takes 'const char *enc_key' but modifies
the memory it points to. This is a logical error in the function
declaration.

The only caller passes a non-const buffer (aentry->ht_key.enc_key), so
the const qualifier is misleading and unnecessary.

Remove const from the enc_key parameter to match the actual usage.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c22291f7cf45 ("mlxsw: spectrum: acl: Implement delta for ERP")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c  | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
index cbb272a96359..0d0cd093b3c6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
@@ -1118,7 +1118,7 @@ u8 mlxsw_sp_acl_erp_delta_value(const struct mlxsw_sp_acl_erp_delta *delta,
 }
 
 void mlxsw_sp_acl_erp_delta_clear(const struct mlxsw_sp_acl_erp_delta *delta,
-				  const char *enc_key)
+				  char *enc_key)
 {
 	u16 start = delta->start;
 	u8 mask = delta->mask;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
index 010204f73ea4..67cc7a5737dd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
@@ -245,7 +245,7 @@ u8 mlxsw_sp_acl_erp_delta_mask(const struct mlxsw_sp_acl_erp_delta *delta);
 u8 mlxsw_sp_acl_erp_delta_value(const struct mlxsw_sp_acl_erp_delta *delta,
 				const char *enc_key);
 void mlxsw_sp_acl_erp_delta_clear(const struct mlxsw_sp_acl_erp_delta *delta,
-				  const char *enc_key);
+				  char *enc_key);
 
 struct mlxsw_sp_acl_erp_mask;
 
-- 
2.43.0


