Return-Path: <stable+bounces-250155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDUVL5fuDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3E5939E6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB6833BC846
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009893BB9EF;
	Wed, 20 May 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIy9JmGg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB53D3D00;
	Wed, 20 May 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294688; cv=none; b=B167fzwMpLSbiTa0XV6vqaIn3cZxHszwtgzOsaycnqJl4FK3h3/XDU/Yx1aYdg78rOIyHAUBKks0fx/x8zzbOQRkjymVaOODucuUPOHbTVcyzbgqSNHILcn5+PVIVsEp80qOoLUkeLGvJExuflMo+22gpw0tsb3Cor+oUdkPlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294688; c=relaxed/simple;
	bh=FiE2lvSYl3t8PmQgolXwikGJjLRgonfcI61XcdM1wcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbKXdKSQaZRbcROASZbh4ZWiMIbAWuGcljmjQ5DvPOr7f5T+DXyy7jml3Ma7clgvCbjxkc4ls+hUc8Ap/hPPUrZ+xZDdW/dqJmVlTa3YrHg8U2FQoybj6FsWv0l9i1KjvYBp2JbXc5H0975jgQuZgA1F+ad0SENca6le1nquyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIy9JmGg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A81F000E9;
	Wed, 20 May 2026 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294687;
	bh=sBGKGYO5QRsdHeP2cPY8WRJQhWncf6H+MybZ09JJ72c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DIy9JmGgcxsaCzDmNs9s315Rs4geBVpcoG1c8fR2ozgnLqi/1hCCbiAt68sDKjoAK
	 dPm47DxiggsHu57pJbH+ANZtynfPGgxScesI72erDBkmk8wAnETBoQUEUPVLn9+rs6
	 bU0pbqNbAXCFjSjfpk2jbomXWE5FtT7JaWblsx5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zeng Heng <zengheng4@huawei.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	James Morse <james.morse@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Jesse Chick <jessechick@os.amperecomputing.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0135/1146] arm_mpam: Ensure in_reset_state is false after applying configuration
Date: Wed, 20 May 2026 18:06:25 +0200
Message-ID: <20260520162151.376858962@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250155-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amperecomputing.com:email,arm.com:email]
X-Rspamd-Queue-Id: 1DD3E5939E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zeng Heng <zengheng4@huawei.com>

[ Upstream commit f91e913355f49c878fc77f995fd71b7800352bd2 ]

The per-RIS flag, in_reset_state, indicates whether or not the MSC
registers are in reset state, and allows avoiding resetting when they are
already in reset state. However, when mpam_apply_config() updates the
configuration it doesn't update the in_reset_state flag and so even after
the configuration update in_reset_state can be true and mpam_reset_ris()
will skip the actual register restoration on subsequent resets.

Once resctrl has a MPAM backend it will use resctrl_arch_reset_all_ctrls()
to reset the MSC configuration on unmount and, if the in_reset_state flag
is bogusly true, fail to reset the MSC configuration. The resulting
non-reset MSC configuration can lead to persistent performance restrictions
even after resctrl is unmounted.

Fix by clearing in_reset_state to false immediately after successful
configuration application, ensuring that the next reset operation
properly restores MSC register defaults.

Fixes: 09b89d2a72f3 ("arm_mpam: Allow configuration to be applied and restored during cpu online")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Acked-by: Ben Horgan <ben.horgan@arm.com>
[Horgan: rewrite commit message to not be specific to resctrl unmount]
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Jesse Chick <jessechick@os.amperecomputing.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/resctrl/mpam_devices.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 0666be6b0e88d..3c7e69de753ef 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2694,6 +2694,7 @@ int mpam_apply_config(struct mpam_component *comp, u16 partid,
 					 srcu_read_lock_held(&mpam_srcu)) {
 			arg.ris = ris;
 			mpam_touch_msc(msc, __write_config, &arg);
+			ris->in_reset_state = false;
 		}
 		mutex_unlock(&msc->cfg_lock);
 	}
-- 
2.53.0




