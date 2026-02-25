Return-Path: <stable+bounces-218869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFY1LBxWnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FAE1901B6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6EFB32AE569
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B5288530;
	Wed, 25 Feb 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U3sDoauu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB16273D6D;
	Wed, 25 Feb 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983755; cv=none; b=qs/I/k2ADWY6VMSyuh1WvowKPbsRZCQfdHlL056izKKU/ioy3up50icj9AuGoZ8SM2hVZX85mXQEonB6KKBMFPOs/WifRS9GEmOtjXPzyJMFCFWZ7ooea8x799QJqz7Jlm4XoXLoZO7dfoRVbweGJdfdeqUm3vWIuZVeg6qU6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983755; c=relaxed/simple;
	bh=XUpJIuRllOpVzgU4MXlMK1ShB04gElXnUAjNlMjjCbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd2feqhp6YurwymsPdDggrkAF0R0qHaVDsy9cADUlFgz7bMBdK7RuFxdKnH0IqB9zsx+5+ke00YgR9QaTGnh/I5BJS2yLdYc5fArtXqxy39JZzGMG5R0rYp7dOML0sFoODl1bKPMYTT5H1jL8A8ON0eccOd6pnUn6M5fA2SLKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U3sDoauu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211E4C116D0;
	Wed, 25 Feb 2026 01:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983755;
	bh=XUpJIuRllOpVzgU4MXlMK1ShB04gElXnUAjNlMjjCbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3sDoauuvlOVzZijhtUGaZ9qEnSKyuSMai6R4YfJ/h1xpYIoNjdXVta7cpH5o3ART
	 kn9Hh7yRWak0CZurCjIlbByizTI9eB6lCMzrEpXAZ5Ut+8fPXmwmqRfjwOK3gzjL9b
	 8PWMr3iMyyHwINwqSLX5/NPRw73i6IkgqHLCgN2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 009/641] device_cgroup: remove branch hint after code refactor
Date: Tue, 24 Feb 2026 17:15:35 -0800
Message-ID: <20260225012349.166789729@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,debian.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218869-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 29FAE1901B6
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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




