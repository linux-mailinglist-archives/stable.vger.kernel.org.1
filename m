Return-Path: <stable+bounces-220677-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPcOJvc+o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220677-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F961C6C33
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCE9930C020C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82A3F529C;
	Sat, 28 Feb 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFDpGdSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F23F5A7E;
	Sat, 28 Feb 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300559; cv=none; b=abKT/mkWHxGZk0rcicqE15z90wyFQS4W3kFL/U2FL1XgSYt1/FkD23uvak7IMtTwmz3uq0k/UQwq+VWuYVa8Y90SQvuj8tAOu5ipjw4tJSNDUTaU0htf4Jywq0ElSuyMKRNRRdc8i5R2Wf/2pnK1p2udc8npdiVnvLhCVOMk0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300559; c=relaxed/simple;
	bh=xmQi6+YKV9ITXwuL3p4IK8mL4FzIuikf+SuQGHCJe74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHC9y4Nz1yZYOiNSkeNNBk91n1JnGthZjknx/Ygd1YQmEMSB99UNOVcZCSaX27ef/Su/SLF+aRghPm4QEA7b2jiLt0Kx9rz4D/EcQAkGjWph5h3tL/fHx21iCdwTMjYvXI5St6t8Pmq5TL6XJtYhzQvnglR22kjqo6F71wkjUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFDpGdSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEC1C19424;
	Sat, 28 Feb 2026 17:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300558;
	bh=xmQi6+YKV9ITXwuL3p4IK8mL4FzIuikf+SuQGHCJe74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFDpGdSZa/Jt3poWhI0N3LY8QLSDiejQWinMe0NcgdGr84IxaSEZsTBoDagd1lFwU
	 1UHWs3K/PQQ3TQbS08VG6Ywp2AcKp8vQn0K2zaN1PBmv7aB2oV2JmOiPrudQYwEp8k
	 Yl7LMgRMiH9PY+x9xnxY++5M3YITrYydhxJgId+bg2PC45RWF7bPW+iS6r75ykbi+s
	 qE7z01ejkcSfe6c0uakMk4IaIbjVih1kGWnwsBV5DLgujy2p9FRl9IMtFnBzRrDx1U
	 tRV5PG2wzqml0Jfe0qUZKA+7X1Nh8FnLJ0rnzFjNoMVT4/Bwxnf+cZ8+EFG+MYIAh1
	 q4+QcqX3cjcMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 598/844] platform/x86: ISST: Add missing write block check
Date: Sat, 28 Feb 2026 12:28:31 -0500
Message-ID: <20260228173244.1509663-599-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220677-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 36F961C6C33
X-Rspamd-Action: no action

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 0e5aef2795008c80c515f6fa04e377c6e5715958 ]

If writes are blocked, then return error during SST-CP enable command.
Add missing write block check in this code path.

Fixes: 8bed9ff7dbcc ("platform/x86: ISST: Process read/write blocked feature status")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260107060256.1634188-2-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 34bff2f65a835..f587709ddd473 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -612,6 +612,9 @@ static long isst_if_core_power_state(void __user *argp)
 		return -EINVAL;
 
 	if (core_power.get_set) {
+		if (power_domain_info->write_blocked)
+			return -EPERM;
+
 		_write_cp_info("cp_enable", core_power.enable, SST_CP_CONTROL_OFFSET,
 			       SST_CP_ENABLE_START, SST_CP_ENABLE_WIDTH, SST_MUL_FACTOR_NONE)
 		_write_cp_info("cp_prio_type", core_power.priority_type, SST_CP_CONTROL_OFFSET,
-- 
2.51.0


