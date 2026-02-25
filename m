Return-Path: <stable+bounces-218047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAK8Ot9PnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:26:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76418EA59
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 253F7300898B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF882522A7;
	Wed, 25 Feb 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byvc+Gqy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87C251795;
	Wed, 25 Feb 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982812; cv=none; b=aQ0C12y8ZNMcW97VUladGxC6/g5JOlGGwFCfCtFea1ZHr7r/K/I76PZ43jktreDMRcI1eK5JuWbJp0YqMRsbHzgLMOi70z6qJ6H1Z6iwGY3mH7pje4rbpo3EsZN4YpiWS9zg4ERGbrVVcQ3YPgnkvczY43VxPIwjV/LpS71D8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982812; c=relaxed/simple;
	bh=5VFJjOYyBdKuxGRUTvHYUcv9oFCe2XjyuKj6jMkYo9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHdGNkHSQe7Cg30xKjzw6/SVl9O9oNrZEPfuDNHaGPLInn4mlvN2QKivTpTAXmttaKI2Ktbh/EoNtTF4DD8cs8MfQrYSEelsiTNRMBX/yDfDuVOfS/hmNoxEhhA+oyl0k447KUth5HGCFsR4WVdMxO10v3DhAqJdyj5aIsK0lPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=byvc+Gqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E14C116D0;
	Wed, 25 Feb 2026 01:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982812;
	bh=5VFJjOYyBdKuxGRUTvHYUcv9oFCe2XjyuKj6jMkYo9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byvc+Gqy6xipvbn09VPdgidG9DQTCZshWC2XDmh3oHVi9z76E3Lb0dXtMpqoTVUqD
	 9k3IjzKuYbcjrR5kKNC3fGlXOl6AQBlO0rnqpBmv2zF3HwWK7xRzAK2obJ8Oiu4fzR
	 LCs87uium9fCMI14ua0Yv99d+SzjjbtdK0usbt7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 010/781] device_cgroup: remove branch hint after code refactor
Date: Tue, 24 Feb 2026 17:11:59 -0800
Message-ID: <20260225012359.954820805@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218047-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,debian.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA76418EA59
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 6784f274722559c0cdaaa418bc8b7b1d61c314f9 ]

commit 4ef4ac360101 ("device_cgroup: avoid access to ->i_rdev in the
common case in devcgroup_inode_permission()") reordered the checks in
devcgroup_inode_permission() to check the inode mode before checking
i_rdev, for better cache behavior.

However, the likely() annotation on the i_rdev check was not updated
to reflect the new code flow. Originally, when i_rdev was checked
first, likely(!inode->i_rdev) made sense because most inodes were(?)
regular files/directories, thus i_rdev == 0.

After the reorder, by the time we reach the i_rdev check, we have
already confirmed the inode IS a block or character device. Block and
character special files are precisely defined by having a device number
(i_rdev), so !inode->i_rdev is now the rare edge case, not the common
case.

Branch profiling confirmed this is 100% mispredicted:

  correct incorrect  %    Function                      File              Line
  ------- ---------  -    --------                      ----              ----
        0   2631904 100   devcgroup_inode_permission    device_cgroup.h   24

Remove likely() to avoid giving the wrong hint to the CPU.

Fixes: 4ef4ac360101 ("device_cgroup: avoid access to ->i_rdev in the common case in devcgroup_inode_permission()")
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260107-likely_device-v1-1-0c55f83a7e47@debian.org
Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/device_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index 0864773a57e8f..822085bc2d202 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -21,7 +21,7 @@ static inline int devcgroup_inode_permission(struct inode *inode, int mask)
 	if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)))
 		return 0;
 
-	if (likely(!inode->i_rdev))
+	if (!inode->i_rdev)
 		return 0;
 
 	if (S_ISBLK(inode->i_mode))
-- 
2.51.0




