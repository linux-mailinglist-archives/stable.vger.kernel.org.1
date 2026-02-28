Return-Path: <stable+bounces-220846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BDBAYVZo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:09:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6584C1C8D21
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FFEC31F2CDE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1133419985;
	Sat, 28 Feb 2026 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGQkTTMm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B84419969;
	Sat, 28 Feb 2026 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300733; cv=none; b=q09rL1P0GjQQcJsjwq6U/spGvwn3m2/ofNLBLIpB18N+CT2eoBnNrD8k4212iDH6lmEHjOzfA5cdXdmZzk4g7AOXGIjd5/CXhmMxSOpHTbUBMS+nMuhMsLiOn6HO1Js0jtjrJqny69rXqANXPVEu9eJDtfrxG+ZKXlvrDGE2i+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300733; c=relaxed/simple;
	bh=6nj11AkLtWQxIa78AOEDTUX1bUEgcX2hoEIeXFyozq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onNw+6g3e1FqC0GaDF0RlRhedDbhwy79SjSMZ9j5VnoReiOOEEeSxD8IqMrxHAGnuF3V+j2RNDImVOZG0kGFs+LVPb4aAkZoNgoffaqrFTJLiLNhv9OqfmnydSdJbTCKbntN/axeABzz4BPMY3OoX8eQnee1PQdVg8cM5nes3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGQkTTMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD2BC19423;
	Sat, 28 Feb 2026 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300733;
	bh=6nj11AkLtWQxIa78AOEDTUX1bUEgcX2hoEIeXFyozq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGQkTTMmGYScHBI/Lz3quJ6PPEasY8ULn7dE6SgKMlUv4aMOcHXwm4QbllZWgBQNn
	 VNpQop7whIsHJaLgXldpq/ybTBdoJUHC7btMyIgP4Qac1L6TtTducrNp7nh8t4SnAu
	 TNyyEUk2iQhgX15zhDtrEC3+M6SMviG0G+qEFApR64WpseuzIwpN6EJh/bSXoX3QK+
	 8Y8mKZt/tzpXJR2M80170nNas4FV0VPWbotI/TM0V9J/ClPreV4912m3jKxlzgqvLk
	 Lfz7/Gqf0pD9n4ga5ZInh+rw9RWe3PFza+bRaFmx7Uh9x3Rrxh597ogWDBXl5Yjz6q
	 fM+GDQQZ8Zwaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 767/844] drm/i915/quirks: Fix device id for QUIRK_EDP_LIMIT_RATE_HBR2 entry
Date: Sat, 28 Feb 2026 12:31:20 -0500
Message-ID: <20260228173244.1509663-768-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220846-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 6584C1C8D21
X-Rspamd-Action: no action

From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

[ Upstream commit 510e7261a7bcd6232e90f0b6b9f93303bdd29f8a ]

Update the device ID for Dell XPS 13 7390 2-in-1 in the quirk
`QUIRK_EDP_LIMIT_RATE_HBR2` entry. The previous ID (0x8a12) was
incorrect; the correct ID is 0x8a52.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969
Fixes: 21c586d9233a ("drm/i915/dp: Add device specific quirk to limit eDP rate to HBR2")
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20251226043359.2553-1-ankit.k.nautiyal@intel.com
(cherry picked from commit c7c30c4093cc11ff66672471f12599a555708343)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index d2e16b79d6be1..1abbdd426e587 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -239,7 +239,7 @@ static struct intel_quirk intel_quirks[] = {
 	{ 0x0f31, 0x103c, 0x220f, quirk_invert_brightness },
 
 	/* Dell XPS 13 7390 2-in-1 */
-	{ 0x8a12, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
+	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
 };
 
 static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
-- 
2.51.0


