Return-Path: <stable+bounces-212521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDHJKFs0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:07:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C724A5216
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F208B31FE903
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B2630CDBE;
	Wed, 28 Jan 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="US8KuVJb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18962874FE;
	Wed, 28 Jan 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615796; cv=none; b=A4WicPATVNTDQobgz8NiDymOzoeqrXsqEHgAU1KbdQWXa634OJG5i20LuoaHry+4/qtP5DCksvPJz2dKWtmNJdFngMF93L7oBy7BUi9NSLsOrM7NRHQjCdlyqs7NbpZb1tGJ9PZZMO89RhezkZ8LhyWk5E3hnSwLCKlDVjAtUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615796; c=relaxed/simple;
	bh=ds59UJqtC1tRaznlPt4icHJkG4uCXyM4XPUO7ZckUZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZOZq634lWktQvvI/EU6PN+2zPUlrmlKmaz8Bk7qduEczW6QgIqPG2c8eLRwkID8adxAkQLmK76qspeE7qFLUJN5YzjTTAnkVHwSOeLpYM/q+7cKpkpU2A8+or/QsM3zAaGZ3xbznNR7l63Z1pI38f5AMLklFOG5zTw96WrLGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=US8KuVJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F8FC4CEF1;
	Wed, 28 Jan 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615796;
	bh=ds59UJqtC1tRaznlPt4icHJkG4uCXyM4XPUO7ZckUZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=US8KuVJbUSGS6WYx+Q3wdU4PpPlpHRctWqeXzmXMRdFtaCcpPUpxr16rw8nw4IXEw
	 Cxr3WoIKY/KcRFiUI1fJhTiJ0pSZeg8up5luv0Ct2CYm7E4gsGvDBOp9x8ms18vFwU
	 AIN/OULby5Fnp9c1gSuBQvp4vOBoS26qCXQDwfDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 099/227] drm/xe: Disable timestamp WA on VFs
Date: Wed, 28 Jan 2026 16:22:24 +0100
Message-ID: <20260128145348.028961226@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212521-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0C724A5216
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit b886aa65eafe3098bbd691f0ca4a9abce03f9d03 ]

The timestamp WA does not work on a VF because it requires reading MMIO
registers, which are inaccessible on a VF. This timestamp WA confuses
LRC sampling on a VF during TDR, as the LRC timestamp would always read
as 1 for any active context. Disable the timestamp WA on VFs to avoid
this confusion.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Fixes: 617d824c5323 ("drm/xe: Add WA BB to capture active context utilization")
Link: https://patch.msgid.link/20260110012739.2888434-7-matthew.brost@intel.com
(cherry picked from commit efffd56e4bd894e0935eea00e437f233b6cebc0d)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_lrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 47e9df7750725..d77ef556e994e 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1050,6 +1050,9 @@ static ssize_t setup_utilization_wa(struct xe_lrc *lrc,
 {
 	u32 *cmd = batch;
 
+	if (IS_SRIOV_VF(gt_to_xe(lrc->gt)))
+		return 0;
+
 	if (xe_gt_WARN_ON(lrc->gt, max_len < 12))
 		return -ENOSPC;
 
-- 
2.51.0




