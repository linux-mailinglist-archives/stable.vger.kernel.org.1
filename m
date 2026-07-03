Return-Path: <stable+bounces-271596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KE16B4MQR2owSwAAu9opvQ
	(envelope-from <stable+bounces-271596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 03:29:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D4A6FDB95
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 03:29:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UgUaS379;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271596-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271596-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9CC3038C49
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 01:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885E220687;
	Fri,  3 Jul 2026 01:29:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9126FBF
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 01:29:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042175; cv=none; b=IO99OEpofM/u/K62tu6k8092/yEbkHp667Qimy5LrXrNMpemht7zJ4Bs5ipBaBe4vvzAyFGO3790hytpe2HaIFSLU1FL0SrtH38TXxcMPHqlKFE2mkY/c6NSX96OQLlsn5N45Hd2Mfsc5z24NhNr5VkrgiWsJXia1lh3c/4gVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042175; c=relaxed/simple;
	bh=R4H6mA5gWgQK/r/Y5vAxwtR8xNPHZPMqcOCUm0SRkBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEKgq3JF29Og5NnOL75oyL++6vKPAZp7nOB89zVsbcSK0k2kA9f921I09grB315MxLPcCEs8vddkh6tQiITs7yBdui1Hv9hEdLRD1Y6WiHUvH1pvFDEl8jiY77MnP6uHomddngSZR0f5RXJcv4Ls2rpzY+umElqtnSriFs91F20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgUaS379; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F71F000E9;
	Fri,  3 Jul 2026 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783042174;
	bh=nTjSNYtdXhy+Eam8oW0BIKRqEAk0k0uZjWWAKwtBxH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UgUaS379kbiHJ9C/wQeqAYHtQzFAikLkMWfQ/uq9QriIdwLS6QpMEXL5RpvMoxz4a
	 T+vMjM/lUgECL/SrnnLFhH9jyOxvhboKrYxAoJB5cVINno4puPjXKeOtOL7oIL32BS
	 d9hQ25QHvcwjudzLI1no94tGJ1MYVvLNz9MQUQk+XEXQrzo9GA3rl67A3g3RP5IX/5
	 09BmdUNdCJyANgl18CWWZC+U48/68uJ3piUvedpgdoYdOXaUds2dBV3lOvsBmEHP9q
	 O7fwpc4pMl/wEhu+RCe5EmAnDojk+2h5PsjBlL47RRvIRMbbKL44qoowma15PKDTdH
	 b4LCeRETCP0fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Thu,  2 Jul 2026 21:29:31 -0400
Message-ID: <20260703012931.3803369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070220-submerge-batting-b601@gregkh>
References: <2026070220-submerge-batting-b601@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:sakari.ailus@linux.intel.com,m:rafael@kernel.org,m:andriy.shevchenko@linux.intel.com,m:dakr@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271596-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58D4A6FDB95

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 7eba000621fff223dd7bab484d48918c7c77a307 ]

If a firmware node is allocated on the stack (for instance: temporary
software node whose life-time we control) or on the heap - but using a
non-zeroing allocation function - and initialized using fwnode_init(),
its secondary pointer will contain uninitialized memory which likely
will be neither NULL nor IS_ERR() and so may end up being dereferenced
(for example: in dev_to_swnode()). Set fwnode->secondary to NULL on
initialization. While at it: initialize the remaining fields of struct
fwnode_handle too just to be sure.

Cc: stable@vger.kernel.org
Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com
[ Fix typo in commit message. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fwnode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 735f6f334a98ff..4b6bf73f272395 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -195,8 +195,10 @@ static inline void fwnode_init(struct fwnode_handle *fwnode,
 {
 	fwnode->secondary = NULL;
 	fwnode->ops = ops;
+	fwnode->dev = NULL;
 	INIT_LIST_HEAD(&fwnode->consumers);
 	INIT_LIST_HEAD(&fwnode->suppliers);
+	fwnode->flags = 0;
 }
 
 static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
-- 
2.53.0


