Return-Path: <stable+bounces-231807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAU5OI//y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80936DF47
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65405308C563
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C6B42668E;
	Tue, 31 Mar 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnmsrt4i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC592EE262;
	Tue, 31 Mar 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975120; cv=none; b=oUsHCDQXX0JJrQbewXh6AT3NFui5ANQST/6hkAzUpUJa1c99ejYbtKUd+ZsskOWC0Ckvvw5FcSQ9QmutKM+CiMxeznpCqfxoP61ZNcX9C/+vUCggy8ZlHyBHMgBCAAXxu19YziZqAM4DXZINlo51zUYsh04+ZBqCrAZNPHzrtRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975120; c=relaxed/simple;
	bh=ey7HGYH8uQBPK/59c8Tvw8a0Ek3OF2QBho9l4yaSxIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CP+yQvCtHt10B1uhe6+2wfTaiANSMmdpMF9FuH/0JdhCs5jU2nHdUgb1FRMCsOeRZMZZyrPEqKz7sZhk8jaAX1agrq0Y558CGcyrIO+0wBBqtCUO+9uOtiERCbMaExk79DCmVZ3oSAa5Q543gIq6cHpSHcW3SekgqQicS27JuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nnmsrt4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9537BC19423;
	Tue, 31 Mar 2026 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975119;
	bh=ey7HGYH8uQBPK/59c8Tvw8a0Ek3OF2QBho9l4yaSxIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnmsrt4i58rOnJAyJ0I45ZSILGuvpUlOM+6P0ITDD3un9wv3PB9ISELfht2ExGlOH
	 wz2q0mv3sCglqWPC5e/KsIcZgmqHE5wYnT9vsHPndiMbGIDL0uoiGOEgTbCesWzOjY
	 z7+M337ptI3dIeQbJUuvqGQJvlA8PAF7GDtK6M2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Sebastian=20=C3=96sterlund?= <sebastian.osterlund@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 172/342] drm/xe/pf: Fix use-after-free in migration restore
Date: Tue, 31 Mar 2026 18:20:05 +0200
Message-ID: <20260331161805.339615952@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231807-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,msgid.link:url,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: DE80936DF47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Winiarski <michal.winiarski@intel.com>

[ Upstream commit 87997b6c6516e049cbaf2fc6810b213d587a06b1 ]

When an error is returned from xe_sriov_pf_migration_restore_produce(),
the data pointer is not set to NULL, which can trigger use-after-free
in subsequent .write() calls.
Set the pointer to NULL upon error to fix the problem.

Fixes: 1ed30397c0b92 ("drm/xe/pf: Add support for encap/decap of bitstream to/from packet")
Reported-by: Sebastian Österlund <sebastian.osterlund@intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7230
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Link: https://patch.msgid.link/20260217154118.176902-1-michal.winiarski@intel.com
Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
(cherry picked from commit 4f53d8c6d23527d734fe3531d08e15cb170a0819)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_sriov_packet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_sriov_packet.c b/drivers/gpu/drm/xe/xe_sriov_packet.c
index bab9946968964..111877b6d44cf 100644
--- a/drivers/gpu/drm/xe/xe_sriov_packet.c
+++ b/drivers/gpu/drm/xe/xe_sriov_packet.c
@@ -342,6 +342,8 @@ ssize_t xe_sriov_packet_write_single(struct xe_device *xe, unsigned int vfid,
 		ret = xe_sriov_pf_migration_restore_produce(xe, vfid, *data);
 		if (ret) {
 			xe_sriov_packet_free(*data);
+			*data = NULL;
+
 			return ret;
 		}
 
-- 
2.53.0




