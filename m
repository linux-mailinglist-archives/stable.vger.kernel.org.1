Return-Path: <stable+bounces-238804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKhXJtIo5mnesgEAu9opvQ
	(envelope-from <stable+bounces-238804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:23:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7C442B9F2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 680F43019D47
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842833AA50B;
	Mon, 20 Apr 2026 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K+7jNfIH"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FF3A257C
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690984; cv=none; b=MEApPE60u/QNFc6I7TcwMjrlMV3izMrnQcMqtYt6QyPGc4Ns0222Zr14oODgxtwehGckrLeQPcShiFPYFzgumeBoK7TlUo1cD/aeREHf8UO2MLfWh4lAxuc80Ez7vaXGJIoUYea2GpjDPW11XIJn+KYRbEwNxEpxrAz/WtUP2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690984; c=relaxed/simple;
	bh=j7hjKUK8Oy6t3mKxAWnnqHggFn1ZaCX4MmbgItRvDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CEno/a6nC4TMUYnNJ7IVWL9xLgGe7GD6SBNoSHveAaOuLufQd1KzKAh/3qavECxTZp1z/7YdzHUlz6Cr8sfb4VMwS8tRBC0GKBWZdynqAKNZTfCL+jgccWIHaWvBVdklTOrF3gbMY1r9yv8nqJG4zMXS//OYuvS4ML1SGvc7rUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K+7jNfIH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6CGzsxyrFnUbeybt0qxvu4NOmZgMCMErE0iT0X9LcZ0=; b=K+7jNfIHjsiynUoisK+d32U/S8
	9FwzmbaMunwtvwIp164SGUIturbazvWIS8ThLvTmywujR0RsPFMi/EBtk6H76PhRoP2K7bpIeEcBU
	Ix80yvy2zqJHWfQdLrDg5oFeC/Ch2DtZAnb2hXmDQJmWrJLKILZE1X+jv5AlVn9Uy4tZZONRsQZvg
	P50EGXMS8X+GJDv+hPeWWmWJFwbuzkjyqga4LBybx5E2u9uySf8vJZ1n9Liy3Tz7QVzB+0HpVMd6L
	UZM75Q4xIei4QAYVeLMT1EDN0Fc+VcS10MYR+YqnMkUPKFWTl5AH2mCXmwGA7l3PqCBfmMbrKVYPi
	8tNywDtw==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wEoTv-0014RB-1A; Mon, 20 Apr 2026 15:16:07 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: intel-xe@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/xelp: Fix Wa_18022495364
Date: Mon, 20 Apr 2026 14:16:03 +0100
Message-ID: <20260420131603.70357-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238804-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3B7C442B9F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Command parser relative MMIO addressing needs to be enabled when writing
to the register.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
---
 drivers/gpu/drm/xe/xe_lrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 9d12a0d2f0b5..c725cde4508d 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1214,7 +1214,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
 	if (xe_gt_WARN_ON(lrc->gt, max_len < 3))
 		return -ENOSPC;
 
-	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
+	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_LRM_CS_MMIO | MI_LRI_NUM_REGS(1);
 	*cmd++ = CS_DEBUG_MODE2(0).addr;
 	*cmd++ = REG_MASKED_FIELD_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
 
-- 
2.52.0


