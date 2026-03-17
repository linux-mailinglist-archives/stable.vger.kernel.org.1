Return-Path: <stable+bounces-226923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFHXIMvYuWlHOgIAu9opvQ
	(envelope-from <stable+bounces-226923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:42:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC72B3247
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287F6308ED53
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F733E5ED6;
	Tue, 17 Mar 2026 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sefz77/0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCDD3E3C5F;
	Tue, 17 Mar 2026 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787334; cv=none; b=ixCNm/UfAEpFb1tHgjALQYYgxuVcndnUOSm1dC8mVXYeIq9cWRFQ+L+IMmBvz8IwpGod7jN7YoEd1CDpaO9boC4ON1bF4WNsG+5eEd7I4eetp7PQ/HPtTq3iSr4wNBb8B92HhXpkBRltEAwLTNMv9ojUWW8jwSdOnBMehlzS5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787334; c=relaxed/simple;
	bh=QdKw4f/MGqXb5H99rYWCACPHZU8X04ZL8sww2QN6OZA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KvOCN8c8lvXlPSzGL0dgp/YiVv4hNFJ07x4GeymgFzZM4mSf1/2yFhH5Zu9JM17QFZcDQZv+Nq2WL/erNpPE3Thwp/e/ySddANxCXfO2u3nUHgqNvxBGokWf0jaj3c3f9EiXPKX/9kbHeSn0omEGMKDsT3MUsrbEgBN+dn6A1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sefz77/0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ofMa0/9wlAGvcjEpPMNHPWwBvZBFU0APi2CCH5/zA0I=; b=sefz77/0u7GPQtn3w/kiKXjN3+
	y9n5oLcWzm79VYxKXFGYR97ppT5TMgbt2/S2p4l1ONRIBSGEypAxTIh/hJE+slBO0Mf0nHwBxY9oc
	sJLiW/nceaEu8WLTPyO7oeWAOieMdVXlOiylKWCS/YxlzPMcmh3pRjpbvtWj4ik6FgNw/QyIZhYFC
	SS6m182rzoUr4IurF/PCOrl44jeBJaTTeiNcpm+ytY8dV4CcSYCZZBqtSPqY5Ck1VXaKRUg+f+32a
	vMg/WC87FCvdsZPV5RW4AWhxyJiKvDNMghtFZiFke+pSWVdhJnCcJB7K6aFOOEzvcLFSDCPEaj0Dp
	1BujCdyA==;
Received: from [189.7.87.203] (helo=janis.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w2d6y-002VQv-Uc; Tue, 17 Mar 2026 23:42:05 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] pmdomain: bcm: bcm2835-power: Fix ASB timeout and
 clean up polling loops
Date: Tue, 17 Mar 2026 19:41:48 -0300
Message-Id: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKzYuWkC/x3MSQqAMAxA0atI1gZsggNeRVxojZqFVlonEO9uc
 fkW/z8QxKsEqJMHvJwa1K0RJk3Azt06CeoQDZRRkbEpsbcLVZzj5i7xuOsi7tjRkGXmyjAVDLH
 dvIx6/9+mfd8PwVsw7GcAAAA=
X-Change-ID: 20260317-bcm2835-power-timeout-12c333813263
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>
Cc: kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=QdKw4f/MGqXb5H99rYWCACPHZU8X04ZL8sww2QN6OZA=;
 b=owEBbQGS/pANAwAIAT/zDop2iPqqAcsmYgBpudi4JQvySB5Y8bxPiu6wK1lvRuiX9uItR+aWZ
 DepT8ifVMCJATMEAAEIAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCabnYuAAKCRA/8w6Kdoj6
 qkjeB/0TZirqsJV85CRS6UflHgIyHqeElHAZAbD/6cbZ4b2SgCH5uFahjdJs6aSarfQIHU3d7f+
 4ARIIvk7wxL3nRTTRkml5OSVjltRGaf0RxFHhUqzim/jCmwTkrzvUu1vBxGCfZM9Ea7usesGBd5
 axS9DRVc9S0SKh0qVQDwbmXpIr9/OS5somlhqcXcV+d8t7dav/Vpe6ac6WQcMWwFYBA1JGsOgQY
 qp0Su2OrxOWT6wyWxPXygnMeud2mNE4jmQ15Y9FqP5f5WIiaatgTG0WmBpfAqWZZSGBgYqGQUBb
 QvVn+nNNRoJKeCVjfEg8TE1gqNfgRFjtB8UZMGuUDYLRNrHm
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linaro.org,broadcom.com,gmx.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226923-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1AC72B3247
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This small series is a spinoff of the V3D power management series [1],
addressing intermittent ASB bridge timeout failures observed on BCM2711
during V3D runtime PM suspend. It also cleans up all polling loops in
bcm2835-power.

Patch 1 fixes the issue by increasing the ASB control timeout from 1us
to 5us and converts the polling loop to readl_poll_timeout_atomic(). Due
to the large changes in the patch, I preferred to drop Stefan's R-b from
it. If possible, I'd appreciate it if I could get another review from
Stefan and also if this patch could be pushed to the -fixes branch.

Patch 2 extends the readl_poll_timeout_atomic() conversion to the
remaining polling loops in the driver (POWOK and MRDONE).

[1] https://lore.kernel.org/dri-devel/20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (2):
      pmdomain: bcm: bcm2835-power: Increase ASB control timeout
      pmdomain: bcm: bcm2835-power: Replace open-coded polling with readl_poll_timeout_atomic()

 drivers/pmdomain/bcm/bcm2835-power.c | 37 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 24 deletions(-)
---
base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
change-id: 20260317-bcm2835-power-timeout-12c333813263


