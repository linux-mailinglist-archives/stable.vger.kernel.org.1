Return-Path: <stable+bounces-220317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDpFJUA1o2kI+gQAu9opvQ
	(envelope-from <stable+bounces-220317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E21C5FA0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B958734BC93B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410FD391899;
	Sat, 28 Feb 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXi6gh+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D5391890;
	Sat, 28 Feb 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300219; cv=none; b=qfbgauisBUyN9x7V6RvBDXpPTkuICpOpisS1vYccw2VB42ImBtSrtJwKkmSEI7Nc/OUJ2qOcp8TESy1yXOwgvQid3p7rY7LfazAkpkUNIOUagcEmOB3yJs6FdwNNO1sJXMPtj4N/rCTLYlVTjFtTPUP5DeyWEvC4zKZq/DllJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300219; c=relaxed/simple;
	bh=kuip02XYYUcT7Wff0IA+vk3H5TdO8JVrUUmowrLODW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLHBsErdI6iqULmoPDkcUDt+XZe1T1S5wqRot+Sor4+iOpbpZwqRRyhX80WcRG3KXGfaNLcFG1YTz6PSbAA+dcDt7Yogq/Q7jpwiFoBoZhxDDanLCUwsJ3ge4keRNe7b3DNA9HZmsKrPyI/R8Mf7eWoxqEe+QvQYh7DR1wHrh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXi6gh+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1E9C116D0;
	Sat, 28 Feb 2026 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300218;
	bh=kuip02XYYUcT7Wff0IA+vk3H5TdO8JVrUUmowrLODW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXi6gh+Esnq7j9rFXVmLzCZ9Nw/kq2I+uN43FDlsiwLpJWRw6GUUBWxpN5fI+Qikp
	 Z8x9KakJZaMun/kd+V4iuVkfVF5RpeRGOBq8V91/GhV9b/5pGWbkXRBFGxwiqeVPQK
	 jC0ajJcc5Rr6+vvNc2pv2yHsGow2S6h/jMoVEu7ITbxveaqCj2wVRpE3NozoPso8JC
	 g5eCS58y+HTIH3ValG8B03BqiLBpuVIdT9kowMAtx1GwtIUvUyNtkpUHh1lg5W+muw
	 G+/T9NJCgDzb3tuGc3p8gmnD8Sl32upYf65FwmxvJYUwGjY4uE7wXJuvxlZ5B0RkDP
	 obGbNEjqKYf4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 239/844] power: sequencing: fix missing state_lock in pwrseq_power_on() error path
Date: Sat, 28 Feb 2026 12:22:32 -0500
Message-ID: <20260228173244.1509663-240-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220317-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E87E21C5FA0
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit e1dccb485c2876ac1318f36ccc0155416c633a48 ]

pwrseq_power_on() calls pwrseq_unit_disable() when the
post_enable callback fails. However, this call is outside the
scoped_guard(mutex, &pwrseq->state_lock) block that ends.

pwrseq_unit_disable() has lockdep_assert_held(&pwrseq->state_lock),
which will fail when called from this error path.

Add the scoped_guard block to cover the post_enable callback and its
error handling to ensure the lock is held when pwrseq_unit_disable() is
called.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Link: https://patch.msgid.link/20260130182651.1576579-1-n7l8m4@u.northwestern.edu
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/sequencing/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 190564e559885..1fcf0af7cc0bb 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -914,8 +914,10 @@ int pwrseq_power_on(struct pwrseq_desc *desc)
 	if (target->post_enable) {
 		ret = target->post_enable(pwrseq);
 		if (ret) {
-			pwrseq_unit_disable(pwrseq, unit);
-			desc->powered_on = false;
+			scoped_guard(mutex, &pwrseq->state_lock) {
+				pwrseq_unit_disable(pwrseq, unit);
+				desc->powered_on = false;
+			}
 		}
 	}
 
-- 
2.51.0


