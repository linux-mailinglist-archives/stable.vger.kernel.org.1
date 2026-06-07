Return-Path: <stable+bounces-261053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iwllEvhEJWoLFgIAu9opvQ
	(envelope-from <stable+bounces-261053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A064F755
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:16:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=1jC3yUNY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261053-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261053-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BBAD3047069
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2628688C;
	Sun,  7 Jun 2026 10:11:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FF1E98EF;
	Sun,  7 Jun 2026 10:11:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827107; cv=none; b=I2f+Jk/RaIvSTGT4kTtwEuGlu/MHQQHKKaIbtaHDwI3zlupw3BJQFt36upbj55xPo5iSBfn1rKdI50lvlzst5oEw6O98da+MrWRrt7dCXtRQNaHwXiVsaIQaE4LowtOfeXX9eZ+4qI5FIBdL6woI7Sk8vk9YbhozuuRlQohUxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827107; c=relaxed/simple;
	bh=sGeie/N9evyiXEry9c7PKDtk2mI2abCfhhzw5zbNTmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMZ1041ADX1z/qXr3DLrHlRNWtTNUSDWbv85fsgcRH2EdnXniPbQFay+v6Hz/V0peumvT3kx66Yv0De9Mw7IafqyIDeG7uc7GGVApRlXEZlBdar9nv40cj1ANVaWN984iaJDyhk+iH0qNK6n4pWNPtY4/fUnwlx3ELwJbtgPxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jC3yUNY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703F21F00893;
	Sun,  7 Jun 2026 10:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827106;
	bh=AGJ+WARc0Pn6OhGDxIpA37jI5nWczeW3ITfSvknJlSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1jC3yUNYvREk8Mjp4EVKZQKJyHP1j24PiNmJB46WmcFl+Q+aFuWnjuiy1Q7xe+tok
	 oKKV8L1Fdzb1I1qBT37DTCyTzmqKJlpUKqkSXUUuWqUE+S7lPRKhOLnj4b7WaJuTMB
	 Q5dU+wSdeL/vEUixSBpz2ytdywjXxEc9JzKRFkNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Roper <matthew.d.roper@intel.com>,
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 063/332] drm/xe: Restore IDLEDLY regiter on engine reset
Date: Sun,  7 Jun 2026 11:57:12 +0200
Message-ID: <20260607095730.447731873@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261053-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:matthew.d.roper@intel.com,m:balasubramani.vivekanandan@intel.com,m:rodrigo.vivi@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A71A064F755

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>

[ Upstream commit f657a6a3ba4c20bc01f5be3752d53498ee1bfe35 ]

Wa_16023105232 programs the register IDLEDLY. The register is reset
whenever the engine is reset. Therefore it should be added to the GuC
save-restore register list for it to be restored after reset.

Fixes: 7c53ff050ba8 ("drm/xe: Apply Wa_16023105232")
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20260522163531.1365540-2-balasubramani.vivekanandan@intel.com
Signed-off-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
(cherry picked from commit df1cfe24743a93b71eab27687e148ab8ae9b69e3)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index f4cbc030f4c81b..904225cbff0d8a 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -770,6 +770,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
 		}
 	}
 
+	if (XE_GT_WA(hwe->gt, 16023105232))
+		guc_mmio_regset_write_one(ads, regset_map,
+					  RING_IDLEDLY(hwe->mmio_base),
+					  count++);
+
 	return count;
 }
 
-- 
2.53.0




