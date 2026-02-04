Return-Path: <stable+bounces-214249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AupMNZog2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26998E9295
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C770931B5D58
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E141C5D57;
	Wed,  4 Feb 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KIvJM3EA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447EF22332E;
	Wed,  4 Feb 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219061; cv=none; b=M+ZkIU2+p4bZGB1//yTH78w/8DRKcEQYuQMjufsf/3SbE+yD5OoMKMpiqNkJDd0dMNKCVI6OL/qOsEJaVoxaAWXhtQU17+YfCTgViB6U0+0l0kJuJVRj2WO3i6zG/LALpg30l3DdY8xk4zHsPBMYYaoEW4oF81ffA6dnZd40ZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219061; c=relaxed/simple;
	bh=iXIGT5fuAQYVzUsqdWSvEKJT5e7bCbEyDLRaThxH4Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2F9dGTJSjvoxd5GpEADPJ9TcBCjn4ZxaeIhNRM/1GUiKmU98fv9WSukbXYBnQuDDOowbF8ouB0+YbQYhbiaURFgNdAPcGHbiA+sMidaOe0CqoJAl6iMSYoUloCmh8Sh4DWxp35V4q9RWwna1km6L8Wl7O92h5LxqKu13laPKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KIvJM3EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FC3C4CEF7;
	Wed,  4 Feb 2026 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219061;
	bh=iXIGT5fuAQYVzUsqdWSvEKJT5e7bCbEyDLRaThxH4Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIvJM3EAx+GzrUrz4uVVAOpUejTfg6t6NE+m3pfKRtXX/2CQilgcFeWZHbTNPdOUy
	 5rwx5wx4q3xd5W6Lu3wYrS78R7jtu9O2WNZzIDv0n2SmcK9ExcOTOQBYy/gjQWA0As
	 /N+/tWM4gq+rt3wPCbOYRtykh7/hF0HMrtYNTF9s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/122] drm/xe/configfs: Fix is_bound() pci_dev lifetime
Date: Wed,  4 Feb 2026 15:40:36 +0100
Message-ID: <20260204143853.798466033@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214249-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 26998E9295
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit c1ed856c09d0d730c2f63bbb757cb6011db148f9 ]

Move pci_dev_put() after pci_dbg() to avoid using pdev after dropping its
reference.

Fixes: 2674f1ef29f46 ("drm/xe/configfs: Block runtime attribute changes")
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patch.msgid.link/20260121173750.3090907-2-shuicheng.lin@intel.com
(cherry picked from commit 63b33604365bdca43dee41bab809da2230491036)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_configfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_configfs.c b/drivers/gpu/drm/xe/xe_configfs.c
index 1396634231857..6688b2954d20b 100644
--- a/drivers/gpu/drm/xe/xe_configfs.c
+++ b/drivers/gpu/drm/xe/xe_configfs.c
@@ -258,11 +258,10 @@ static bool is_bound(struct xe_config_group_device *dev)
 		return false;
 
 	ret = pci_get_drvdata(pdev);
-	pci_dev_put(pdev);
-
 	if (ret)
 		pci_dbg(pdev, "Already bound to driver\n");
 
+	pci_dev_put(pdev);
 	return ret;
 }
 
-- 
2.51.0




