Return-Path: <stable+bounces-220505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIKVNtw9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0601C6AC1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BD4B318C8C6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF683C9FC5;
	Sat, 28 Feb 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY6fRwDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F73C9FBD;
	Sat, 28 Feb 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300390; cv=none; b=rObg2zKoYQZyLL9K+ZlxKpaqC33SM3S7tUXJd2TIIhg6Qw08Ha9m9Hy5PRawA+n+swgvyw6IHnJ7I/PVqb9lk/VSddSGARiNft0hN/Sqry0C/NwtrR5nAVstBpK7WK7GMj8UQGcoVV1XxR2PamIL+Ya7ldS0bi4wGhkY9eq2kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300390; c=relaxed/simple;
	bh=4GxOB6SFmcshO8Wpj87J+ttVhAfcdXsZRNkgMnA72JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpBgTkPc0lgikJ9gyfWtYlg7CbC9PqxhzhaT2lqpgpgmE7GuRqZq47x24qjwSUy9K7umZRDnHOoCqC+c+UP/iyM1nLjX3AI6Ydf2lCrk/ZB7TE6T8b0Yl1PWN3D7JnKJ99W6XxJm9/csRqJfx1sCkBB8J09dyHsWK9ajaHJeaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY6fRwDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D32EC19423;
	Sat, 28 Feb 2026 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300390;
	bh=4GxOB6SFmcshO8Wpj87J+ttVhAfcdXsZRNkgMnA72JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pY6fRwDerxCpkgE8Fh9oNQCbvZbo5kijxAvN4nCYa629/JtYgGs0Zw+HVX12lkYZ1
	 SCb6g9YXLDFkAPNKxDPGQWyV/M3uxtRFayn75op8TMqmbd+ZhOwpiBDQeTz2iL90iB
	 Mglb0JuEU714Zpa/yHroh4GD9mObxvLFPmhEy9a0xtdP1ZLhKyFU3RGMxFEbEsS6nd
	 zmXNclPQbaNYXCEL7175KiMIK63cLZMxWlx2+lSHWBoOOZbnjmbR/HZ74ndMT7FPzs
	 9rz8EaHuXmbRvFBHV0D4/A3AarDqRwXKDvyCh4tUMHaswC6bHrZ2AW+tQm7gwKPU8g
	 mHCDCNTlb6beQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gangliang Xie <ganglxie@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Kent Russell <kent.russell@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 426/844] drm/amdgpu: return when ras table checksum is error
Date: Sat, 28 Feb 2026 12:25:39 -0500
Message-ID: <20260228173244.1509663-427-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220505-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C0601C6AC1
X-Rspamd-Action: no action

From: Gangliang Xie <ganglxie@amd.com>

[ Upstream commit 044f8d3b1fac6ac89c560f61415000e6bdab3a03 ]

end the function flow when ras table checksum is error

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 64dd7a81bff5f..710a8fe79fccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1701,10 +1701,12 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 		}
 
 		res = __verify_ras_table_checksum(control);
-		if (res)
+		if (res) {
 			dev_err(adev->dev,
 				"RAS table incorrect checksum or error:%d\n",
 				res);
+			return -EINVAL;
+		}
 
 		/* Warn if we are at 90% of the threshold or above
 		 */
-- 
2.51.0


