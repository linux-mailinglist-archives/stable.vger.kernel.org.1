Return-Path: <stable+bounces-220427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPa+E3I2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E241C6144
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA16630FE2DC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE603B340A;
	Sat, 28 Feb 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M29XGtyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C144480DE3;
	Sat, 28 Feb 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300317; cv=none; b=ojXc6xQcoXLQhhe1HtQbLecSRK4aqEBtFtuuOg/4khgocIh/HFUl0C8N0NtWQKWKAyiyt7l1+68YyZNJdJ+kNs/nv+Xn7BG1NBezHegWrxCjKkjm3lyKl4gxfSmlVM7thpI54QO7hrObcuCpNd/cOmtlM21ZYkopMN1Bn8sK7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300317; c=relaxed/simple;
	bh=vKFYXOQmrz68V3Mdx2r/LwhN9YLy57iFoBXg0zOps+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3GFzmCR1uZdhOyv+98UjV4aDLJY01RQza/ANgJD4BcdTZgJwVvv3UgH/7V2X05rpM9uQeQq8yTHnIqMusAB+u+pY0h4tEZyLyqJmr95OxFVlWR7PW6nzw76aG/UIDDBAPAacw82FjQPso3tR0XQjXByGhN9DqDfwvUCKi938tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M29XGtyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E00C19424;
	Sat, 28 Feb 2026 17:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300317;
	bh=vKFYXOQmrz68V3Mdx2r/LwhN9YLy57iFoBXg0zOps+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M29XGtyTDfFn0UekGRnNBIr1hNZKV1ta4SmoF3grcdu6jTS6jxN09/A4YjLgKhmic
	 uOYI93M2svQv7JOrZ86TPwUfu8ix+TWIOXoCTujwWUW5WfUYJyWwOlOcT7m44y9k+U
	 cdkc+I1vbtRyDsg2+vzIWHTJdQDIZErqO5FRmrtPS4Z9lZOUSJTvjOEykl7HgKUDJg
	 Iy069Ex438vNPnnnTXXrMDGt+RO2fFX/l6FlqfubEIJyfLaXFqud5siEdw1fquxZp9
	 ROD9SsrDnNtUld0p9Saf2P1KgJwptCiMAuNNgBiBQJW/HyQXmixr/2z9Dc/1gdd4ed
	 ICMCJyVrMkfhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keita Morisaki <keita.morisaki@tier4.jp>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 348/844] scsi: ufs: mediatek: Fix page faults in ufs_mtk_clk_scale() trace event
Date: Sat, 28 Feb 2026 12:24:21 -0500
Message-ID: <20260228173244.1509663-349-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220427-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B8E241C6144
X-Rspamd-Action: no action

From: Keita Morisaki <keita.morisaki@tier4.jp>

[ Upstream commit 9672ed3de7d772ceddd713c769c05e832fc69bae ]

The ufs_mtk_clk_scale() trace event currently stores the address of the
name string directly via __field(const char *, name). This pointer may
become invalid after the module is unloaded, causing page faults when the
trace buffer is subsequently accessed.

This can occur because the MediaTek UFS driver can be configured as a
loadable module (tristate in Kconfig), meaning the name string passed to
the trace event may reside in module memory that becomes invalid after
module unload.

Fix this by using __string() and __assign_str() to copy the string contents
into the ring buffer instead of storing the pointer. This ensures the trace
data remains valid regardless of module state.

This change increases the memory usage for each ftrace entry by a few bytes
(clock names are typically 7-15 characters like "ufs_sel" or
"ufs_sel_max_src") compared to storing an 8-byte pointer.

Note that this change does not affect anything unless all of the following
conditions are met:

 - CONFIG_SCSI_UFS_MEDIATEK is enabled

 - ftrace tracing is enabled

 - The ufs_mtk_clk_scale event is enabled in ftrace

Signed-off-by: Keita Morisaki <keita.morisaki@tier4.jp>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Link: https://patch.msgid.link/20260202024526.122515-1-keita.morisaki@tier4.jp
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufs-mediatek-trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek-trace.h b/drivers/ufs/host/ufs-mediatek-trace.h
index b5f2ec3140748..0df8ac843379a 100644
--- a/drivers/ufs/host/ufs-mediatek-trace.h
+++ b/drivers/ufs/host/ufs-mediatek-trace.h
@@ -33,19 +33,19 @@ TRACE_EVENT(ufs_mtk_clk_scale,
 	TP_ARGS(name, scale_up, clk_rate),
 
 	TP_STRUCT__entry(
-		__field(const char*, name)
+		__string(name, name)
 		__field(bool, scale_up)
 		__field(unsigned long, clk_rate)
 	),
 
 	TP_fast_assign(
-		__entry->name = name;
+		__assign_str(name);
 		__entry->scale_up = scale_up;
 		__entry->clk_rate = clk_rate;
 	),
 
 	TP_printk("ufs: clk (%s) scaled %s @ %lu",
-		  __entry->name,
+		  __get_str(name),
 		  __entry->scale_up ? "up" : "down",
 		  __entry->clk_rate)
 );
-- 
2.51.0


