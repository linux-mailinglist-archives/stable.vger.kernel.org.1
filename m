Return-Path: <stable+bounces-215416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP+/AQL2iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:58:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC15111494
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D76BB302930B
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D53783C9;
	Mon,  9 Feb 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c6aJV97z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACE37BE77;
	Mon,  9 Feb 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648720; cv=none; b=Ogzshksg3lEIFto/gr3Pj8Q3NgjbveQQw7tyv2HnvqVQJj0lv3qjm+ACSbB4HehqksLkP2GLJUxTxkSiLPePDg+0gPcjKjBSA2KMUfoS/xYokDUF+O1NZCkYQ0p3fy7kln8yTz59Jk3a3Ql1qM8vTKEe3MZkOp0XcMDkY7PjE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648720; c=relaxed/simple;
	bh=5evf2PfkrgfQOORSIiI6EaepKYQxN4gSWmt3lEvXNBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cjl6HR8dP6BSC4zMRJCOlGE4QG/vodBlZWWYCnU/T/UyaMk8Czs+8ZwswWTjyQlyi5pyWPre5MTyowwmL85lxAUenh3JyZdRskWZ6KX0pD70+fcrvOlb6DOAY1i26sFLozop+FIst9htBMXMcBGEQ67NVIo+wfPYx0vvNJbHtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c6aJV97z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6655DC116C6;
	Mon,  9 Feb 2026 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648719;
	bh=5evf2PfkrgfQOORSIiI6EaepKYQxN4gSWmt3lEvXNBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6aJV97zhYfJGf1VumqUBwMOfvcbKTl7pnV/TQynBC93sZEpNNzfDhi4n3Nsl8M9a
	 ca6CGobcGc3OsXqwJWH0YrLp32N3yGIRsu0IvEMJlwjfmJqsTemuUdRQcpNDDsdUQU
	 Tb81AmlUBaqgbQdF8zs4e9yRHVyQbKZWW3H0nNBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 37/41] platform/x86: intel_telemetry: Fix swapped arrays in PSS output
Date: Mon,  9 Feb 2026 15:24:58 +0100
Message-ID: <20260209142258.154219858@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
References: <20260209142256.797267956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215416-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,intel.com:email]
X-Rspamd-Queue-Id: 3FC15111494
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 25e9e322d2ab5c03602eff4fbf4f7c40019d8de2 ]

The LTR blocking statistics and wakeup event counters are incorrectly
cross-referenced during debugfs output rendering. The code populates
pss_ltr_blkd[] with LTR blocking data and pss_s0ix_wakeup[] with wakeup
data, but the display loops reference the wrong arrays.

This causes the "LTR Blocking Status" section to print wakeup events
and the "Wakes Status" section to print LTR blockers, misleading power
management analysis and S0ix residency debugging.

Fix by aligning array usage with the intended output section labels.

Fixes: 87bee290998d ("platform:x86: Add Intel Telemetry Debugfs interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Link: https://patch.msgid.link/20251224032053.3915900-1-kaushlendra.kumar@intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel_telemetry_debugfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -449,7 +449,7 @@ static int telem_pss_states_show(struct
 	for (index = 0; index < debugfs_conf->pss_ltr_evts; index++) {
 		seq_printf(s, "%-32s\t%u\n",
 			   debugfs_conf->pss_ltr_data[index].name,
-			   pss_s0ix_wakeup[index]);
+			   pss_ltr_blkd[index]);
 	}
 
 	seq_puts(s, "\n--------------------------------------\n");
@@ -459,7 +459,7 @@ static int telem_pss_states_show(struct
 	for (index = 0; index < debugfs_conf->pss_wakeup_evts; index++) {
 		seq_printf(s, "%-32s\t%u\n",
 			   debugfs_conf->pss_wakeup[index].name,
-			   pss_ltr_blkd[index]);
+			   pss_s0ix_wakeup[index]);
 	}
 
 	return 0;



