Return-Path: <stable+bounces-232061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJBwBXEDzGmPNQYAu9opvQ
	(envelope-from <stable+bounces-232061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:25:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA936EA94
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C76B31D5FCC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4014035AB;
	Tue, 31 Mar 2026 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xb13bU0Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41A3EF0A2;
	Tue, 31 Mar 2026 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975775; cv=none; b=Cx8Jc86n5YL2IUWKm4S/6MMdewyUsqbUBp9daiBPg+B2QBVfro5ovgGV2uYCN3P097Pvmi5ELNlhkvMgdXxLQOEZkTkevgy4KJnzuH51EOmACQQ3moQum9A5VHjVozlwm1458LQpChWhXgBscJ3FTdpp2V4KzuY3po8WCcWnyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975775; c=relaxed/simple;
	bh=7mQGE8NoNUpuu6PoxOaqw+e7cl6Vx/A6Y6IEFH+JvAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhzd6l+ddPY3q1mMAaki2LlbvJm8DMdAy6TVt6BlSlnYIW3A3w7Qa6VtdeAPuE6x1OelUevmM+uuSx7KqTYkHBJOFUJBtmbxX4WIoIyzrHmCU1w5qSTK5rNPxKlSzYIONyWCB+SECauz1GyNpQRbXdhgEV1zuk5nkylEdUNpM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xb13bU0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D07C19423;
	Tue, 31 Mar 2026 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975774;
	bh=7mQGE8NoNUpuu6PoxOaqw+e7cl6Vx/A6Y6IEFH+JvAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xb13bU0YFzjfYKHI+pQMMWAVmCt91+s+Nx7hPE0zv2t9eOOv7Zg3ZSt99pqUi/Dru
	 p1nbET+Z/t1WfbAb1IS/o0WfClN1GT5zJfZDB5cm7apkcQm6aUJCzvw5lofmJ1w5TY
	 u3dhP/3A4Ao2iqhRQEwQlQs7CTfVvXuANPkDocoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Oros <poros@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Patryk Holda <patryk.holda@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 082/244] ice: fix inverted ready check for VF representors
Date: Tue, 31 Mar 2026 18:20:32 +0200
Message-ID: <20260331161744.711048512@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-232061-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 78CA936EA94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Oros <poros@redhat.com>

[ Upstream commit ad85de0fc09eb3236e73df5acb2bc257625103f5 ]

Commit 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
refactored the VF readiness check into a generic repr->ops.ready()
callback but implemented ice_repr_ready_vf() with inverted logic:

  return !ice_check_vf_ready_for_cfg(repr->vf);

ice_check_vf_ready_for_cfg() returns 0 on success, so the negation
makes ready() return non-zero when the VF is ready. All callers treat
non-zero as "not ready, skip", causing ndo_get_stats64, get_drvinfo,
get_strings and get_ethtool_stats to always bail out in switchdev mode.

Remove the erroneous negation. The SF variant ice_repr_ready_sf() is
already correct (returns !active, i.e. non-zero when not active).

Fixes: 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 970a99a52bf18..1b1288d243248 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -314,7 +314,7 @@ ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
 
 static int ice_repr_ready_vf(struct ice_repr *repr)
 {
-	return !ice_check_vf_ready_for_cfg(repr->vf);
+	return ice_check_vf_ready_for_cfg(repr->vf);
 }
 
 static int ice_repr_ready_sf(struct ice_repr *repr)
-- 
2.51.0




