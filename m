Return-Path: <stable+bounces-220200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOwqKiAto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4CA1C54E8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7828230FB11D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C91B4D2EDA;
	Sat, 28 Feb 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY6uR1/O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4244D2ECB;
	Sat, 28 Feb 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300106; cv=none; b=fJj3G89dqIa2MG0lGmc0bg6g3Q42zgTboPys3n1IKj+OBeBZvA3scHSL/SvthNKRzYClheayvYTJZMGO5r4FRGNBkxoNMO4fQqkmJltMZaEXL1F0/q034j29VoqOT/9mSRU2iMQizVlxmptkpZZ2AAg5tYLHA/hb27S+C8egM2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300106; c=relaxed/simple;
	bh=Mt4jFdGJyq8egqIKlvbkD1pcSAEmCL3DQ1jiF/WWx/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbSO7wXtvWEeLxt6n6zYotGe79vWps2jC7PTeWPOOOQlEa17dmZA0wJ6CjWoWNDd4HuLSfDJh0YqRe/m6AvjVokvY+iCwVuKHMycZvroaya3xFORQMu3s99BqkEiSbFBduX+NOcVHkmmt3eoQaLlpzwN6mmGTpgldoGe5s9nScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY6uR1/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6FBC116D0;
	Sat, 28 Feb 2026 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300106;
	bh=Mt4jFdGJyq8egqIKlvbkD1pcSAEmCL3DQ1jiF/WWx/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pY6uR1/O+6GQ/bc06OQu84gca9yAWUSXkj3v/0HuWAhYhZ+KztRQ8S9Mbkoy93O0v
	 8NGFClWS9ntL4HHI/pb9iTGBlz3au7WPMMPdd7J6bUZN6A631y+doQ4tGJl9XJhuX6
	 14Kj7HOTx22gsh/h5FRbOZ4xQ2APZ8D6PtTzP4zOEVsV68C/dv7gc7rBBpDGXhxqtD
	 YEPp/wRtDbSXXgQ7huPb/67X6vHgaTJI8H+wJOBVDKBFbj1HYJN8Vj241GYcp2URWQ
	 VVnegc9cSojqc5TLA97pkHnAeqnfO38fnnEVolHIfs5SrseGeDnvIPjTxITp5VjySr
	 DTWVcmF+TW9gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Roper <matthew.d.roper@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 122/844] drm/xe/ggtt: Use scope-based runtime pm
Date: Sat, 28 Feb 2026 12:20:35 -0500
Message-ID: <20260228173244.1509663-123-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220200-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4F4CA1C54E8
X-Rspamd-Action: no action

From: Matt Roper <matthew.d.roper@intel.com>

[ Upstream commit 8a579f4b2476fd1df07e2bca9fedc82a39a56a65 ]

Switch the GGTT code to scope-based runtime PM for consistency with
other parts of the driver.

Reviewed-by: Gustavo Sousa <gustavo.sousa@intel.com>
Link: https://patch.msgid.link/20251118164338.3572146-51-matthew.d.roper@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_ggtt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 793d7324a395d..9e6b4e9835424 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -396,9 +396,8 @@ static void ggtt_node_remove_work_func(struct work_struct *work)
 						 delayed_removal_work);
 	struct xe_device *xe = tile_to_xe(node->ggtt->tile);
 
-	xe_pm_runtime_get(xe);
+	guard(xe_pm_runtime)(xe);
 	ggtt_node_remove(node);
-	xe_pm_runtime_put(xe);
 }
 
 /**
-- 
2.51.0


