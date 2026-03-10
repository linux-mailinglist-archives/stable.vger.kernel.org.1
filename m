Return-Path: <stable+bounces-223905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INQ3ARX9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:14:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB0024A32B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72DA5307108E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FEF38656B;
	Tue, 10 Mar 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG910/B1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC53859E3;
	Tue, 10 Mar 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140803; cv=none; b=dXqsWgC2i+EtXsHxPyx6b/Loj/im/M48Mz+Sgui+EqtJNA9Pbti3V1WYeT2I5A414/csN02kFx7aFugPN2JvoQuPqDQJVuqA9ro64O5jf4/55vMNv1So/U5AjodecfeDc/T2FDvSakPMKP4J0fwGVFYI8XDKuMGFND1EMzermp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140803; c=relaxed/simple;
	bh=2CYjOw6iKgznJ42auX7n2z9R0FGZee5FBEAGBx9yqNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBMr2rb9fYgNOrCw3MbdDJQIXAsJVZ4llx8fOGlk6ONXnBld+jnW/4dtx0sq6Q8q1P5TNjCvj5CplCKywggrPSoV+SJzvAPktoTAWYkW7lH/XROmem0J95CmmxudiNOiN1kjXjAb79eq1eohdLqlICCpZK3eMGOqH1kevHljais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG910/B1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DA0C19423;
	Tue, 10 Mar 2026 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140803;
	bh=2CYjOw6iKgznJ42auX7n2z9R0FGZee5FBEAGBx9yqNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TG910/B1zklpRembSm6nKO+q1AlhZpdnFFaj4+0g63bsHrPYGwqWYo1wKHO7jrqfV
	 nsmnhucM8i+ieqb2mEjyqwwsbqQkOe1f8Fp5W7QBMRN1d6L0lO1vCBMLmCjXVUVXV4
	 fjamnd999ZBqHZOhBPQz7oxVQTh11UK+JyTjEp/GFuNRc23to8TwgmLr4it9McNK7F
	 uVquOfOA1tl7ZbNYsczlqTHJhdi4+OhdDq2fplCzeOoUTcpdySCZlGa9WQDFB2Au1k
	 LcfZ7MupqsGdBk/fB8t6CiP3QErKThUl0l0T0EPONBC3AachBoeMyDTjd0d39kCxzz
	 2UM+7MOC426CQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 041/311] accel/amdxdna: Validate command buffer payload count
Date: Tue, 10 Mar 2026 07:01:28 -0400
Message-ID: <9c7de057c54b63040df112139e6c62a95f172402.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EB0024A32B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223905-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
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
index db3aa26fb55f0..e42eb12fc7c1b 100644
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


