Return-Path: <stable+bounces-247989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HFbKtFHB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-247989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:20:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F95530C2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C995A306B8F4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A2F303CB0;
	Fri, 15 May 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q7tnYeNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987453FF1DD;
	Fri, 15 May 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860585; cv=none; b=VYZFq1wOEq9ziV+O6hNWybC1LQUpwiKdU26JxBrzKH0ik62oPvIOoXpKBZ7ONGu2T9TVrf1nYM+pdHGi8o70CZ6IhPp72wWb80B6vEQD8vTy2NJVVxe3NfjtlodcAQV0S0XqN2WB5V0OkY2jEtP2MKpZnhC9nLlR57riCyImf3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860585; c=relaxed/simple;
	bh=2nwN4ulS/kpKI+eAV3sqRd+fCETK43WKuLte86ntFiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhkmJap4dfMeQ7PHHjPT2t+uDw6o3zKKqNyZUet6G8GMCPBtS9tWVucSLirt6iukhc/3blqUpNlyur+UTvI+gyfpFwOCZudnjjkMYJ+CgJQnI6fFM4F1Wch3lDiUPCW6EE4TH2PHcEhmVoRJQtWJ/Fy0ZJdVZRKEepOTuot6ZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q7tnYeNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D8AC2BCB0;
	Fri, 15 May 2026 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860585;
	bh=2nwN4ulS/kpKI+eAV3sqRd+fCETK43WKuLte86ntFiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7tnYeNvidWGYDBonHU0GIUzPR2jtREw3+Zilqc+sjby8aPxD5RAG7SrV3BNHUj0/
	 O+6tqgASUTrZVI3EtSozgQyb2QWk+aKniu6gqcJwRaSKm93OVuD00TXRpbnHvsKNXr
	 +euaX1ziMyXwDeklJqz5aOMrNAmBRe3hzZrV5E74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SDL <sdl@nppct.ru>,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 144/144] drm/amdgpu/vcn4: Avoid overflow on msg bound check
Date: Fri, 15 May 2026 17:49:30 +0200
Message-ID: <20260515154656.866391569@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA0F95530C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247989-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nppct.ru:email,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Cheng <benjamin.cheng@amd.com>

commit 65bce27ea6192320448c30267ffc17ffa094e713 upstream.

As pointed out by SDL, the previous condition may be vulnerable to
overflow.

Fixes: 0a78f2bac142 ("drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg")
Cc: SDL <sdl@nppct.ru>
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3c5367d950140d4ec7af830b2268a5a6fdaa3885)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1830,6 +1830,7 @@ static int vcn_v4_0_dec_msg(struct amdgp
 
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
+		uint64_t buf_end;
 
 		if (msg[0] != RDECODE_MESSAGE_CREATE)
 			continue;
@@ -1837,7 +1838,8 @@ static int vcn_v4_0_dec_msg(struct amdgp
 		offset = msg[1];
 		size = msg[2];
 
-		if (size < 4 || offset + size > end - addr) {
+		if (size < 4 || check_add_overflow(offset, size, &buf_end) ||
+		    buf_end > end - addr) {
 			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;



