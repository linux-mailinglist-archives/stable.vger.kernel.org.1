Return-Path: <stable+bounces-224209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC4eKhcAsGmoeQIAu9opvQ
	(envelope-from <stable+bounces-224209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77624ABAA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F35B93127D00
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6B389454;
	Tue, 10 Mar 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrPsSu9f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D33859CE;
	Tue, 10 Mar 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141663; cv=none; b=ohU/58qVAHk8sorYMBfWKDzyTu9F3wvNyUpaC9V4Ykgs1AnqylW3vhZqNPdY8ESX+M10dHS5zWW2BWQRhfDVL6VujnPRYBTd3xGaXkDllLzCCldIoRkNusUeqyMzxYSuUZPoAdwK/QuxRaXU5B+r/uFdwJyJeN4OeBIZfcFGnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141663; c=relaxed/simple;
	bh=Lq34gKS0CEe5kroUw8u6Jnz0iOVKaelNfEAOG7QtBS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG0v1s3cesZr9oSPGhFF1aW3683fowwcE3KKw6EVS2TjtQr4N4f+gt51QSAVCUwrkMrXeKq9EPnrsJ+B7Ro5Iqk2uIy8+taSmPnhJmFpkmD2XvgZicuOtysHxJYjVopM6/g4E+iRLs8unL2a+8TgS8Gla2kDRvUPEH91c+vB9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrPsSu9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CBBC19423;
	Tue, 10 Mar 2026 11:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141663;
	bh=Lq34gKS0CEe5kroUw8u6Jnz0iOVKaelNfEAOG7QtBS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrPsSu9fNByg2OboxO3D6bw2jHpgKffyt50U8qNgSyUqF2XcNix4GBpSBDJkgYoQH
	 DG2koqghF4TtIs4T4XViwNOD7doptqq0VidOWpCjruYq9y7d5fc8yHtBqf7fcGpv7k
	 RZJAyQh+m+eTi1Tjz+r2rLmn3+FOgE6nP6MdPz2lmDRIy/3fWkX05C8A4yXiGC0QbD
	 krqe7/Ioys2G0p71W+hMbYbPVZv+C0Cunj4RYTPPm6+EGVmOYuxcByzWrSzaKLghqY
	 kYtROmWaQqcbW+yw8CDMSZXgPjpa1VymDpZyYKaMrF1C7sm1wXQx+8AIhixU6DdYKs
	 aBiGPQXOravzQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 030/314] accel/amdxdna: Validate command buffer payload count
Date: Tue, 10 Mar 2026 07:14:49 -0400
Message-ID: <133df64fe3ea424277aa9a179bb25a00bf6e2b58.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E77624ABAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224209-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 901ec3470994006bc8dd02399e16b675566c3416 ]

The count field in the command header is used to determine the valid
payload size. Verify that the valid payload does not exceed the remaining
buffer space.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260219211946.1920485-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 856fb25086f12..cfee89681ff3c 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -104,7 +104,10 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
 
 	if (size) {
 		count = FIELD_GET(AMDXDNA_CMD_COUNT, cmd->header);
-		if (unlikely(count <= num_masks)) {
+		if (unlikely(count <= num_masks ||
+			     count * sizeof(u32) +
+			     offsetof(struct amdxdna_cmd, data[0]) >
+			     abo->mem.size)) {
 			*size = 0;
 			return NULL;
 		}
-- 
2.51.0


