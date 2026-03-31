Return-Path: <stable+bounces-231668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFUEDh35y2lENAYAu9opvQ
	(envelope-from <stable+bounces-231668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:41:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C310336CF3E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 124D330AE6E7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E5425CD6;
	Tue, 31 Mar 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cR7kgbtx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C678402BA9;
	Tue, 31 Mar 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974760; cv=none; b=h78EDMCO1F2ameJA/YCmukbJ6Y0IWCXopeGqhRqAoaeoANq0SwbBiCD+ZEHJkHzRZT/iNYLjqoU1TCAb19W4mMXCdCBG0GK5y9A0fVDFjfU3zZ24voXlbVrnZGiCDHZgssj22CeotS8nfbys1Ty6HRUMgjCt351wkZntsJGHm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974760; c=relaxed/simple;
	bh=yYCu9LhxgGTdG3pq/lEpmjBfA/sXyViEQmnCbJ19Qyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuFKCZShOmbOUWBMvunDbPWAVAX91rnAy4KJl+r4cJXaSsBjRdO1kHi/O1Otj3c9/xi5cCk5wUceXbTd37KE4qNVXmG/OqJ+LOGcGmyg+Z+HRBY97FnbvhFl2rCQnUFf7OBOk00RHO4MKEdaZzueEksNBe9j4h43bN2hKEdaEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cR7kgbtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1225EC19423;
	Tue, 31 Mar 2026 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974760;
	bh=yYCu9LhxgGTdG3pq/lEpmjBfA/sXyViEQmnCbJ19Qyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cR7kgbtx0Wu2TvVLk8ZDIogfBiRCB0LgPtcBwtTkjSpCQAj4oifbbUAzZc3/yzZjD
	 z0bnn4BQnup1dmgG0Xm8G3qHjHokusWTJ9WcGg0WjWMK3JFmoNupjG57hFv8/747TX
	 bImtqr5d2yND7G9T3hdZUarmbFOz7SvTyu8Ev8uA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Lattaro Volpini <victorlattaro@proton.me>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 034/342] platform/x86: hp-wmi: Add Victus 16-d0xxx support
Date: Tue, 31 Mar 2026 18:17:47 +0200
Message-ID: <20260331161800.161862817@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231668-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Queue-Id: C310336CF3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Lattaro Volpini <victorlattaro@proton.me>

[ Upstream commit 249f05e625c6e6c14b27fd34a2f06a1afb9b456d ]

This patch enables Victus thermal profile support for the HP
Victus 16-d0xxx. It does so by adding model's DMI board name 88F8 to
victus_thermal_profile_boards.

Tested on a Victus 16-d0xxx:
  - Victus thermal profile choices available (quiet, balanced, performance)
    instead of the default ones (cool, quiet, balanced, performance);
  - Profile switching works correctly;
  - About 4% increase in FPS using benchmark Cyberpunk 2077 on
  performance profile;
  - No noticeable regressions.

Signed-off-by: Victor Lattaro Volpini <victorlattaro@proton.me>
Link: https://patch.msgid.link/20260210000048.250280-1-victorlattaro@proton.me
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index ec87fd96686cf..e3a7ac2485d68 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -154,8 +154,9 @@ static const char * const omen_timed_thermal_profile_boards[] = {
 	"8BAD",
 };
 
-/* DMI Board names of Victus 16-d1xxx laptops */
+/* DMI Board names of Victus 16-d laptops */
 static const char * const victus_thermal_profile_boards[] = {
+	"88F8",
 	"8A25",
 };
 
-- 
2.51.0




