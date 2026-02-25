Return-Path: <stable+bounces-218083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E2gFH5QnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CA18EC0C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D1803055024
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF325228D;
	Wed, 25 Feb 2026 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mYellDbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87EB2494FE;
	Wed, 25 Feb 2026 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982856; cv=none; b=coEbBbea7Hrv25gH8NF11eF3/kvraT1VWJ3cVfyxYi7MlyX5bFKeK1Sw+CoPIxq79NZ6OoRf5XDFE6gaAEP/eOnKHGD8TYHUxAQafSRZgueYklR0yfXEzIZ6393sDR0FghYpKWmTj+IIgcHT/ZOnp3kmfLTm17Piu5+AIyFbEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982856; c=relaxed/simple;
	bh=KztvUChYH4qoBTwo76/6FhE6p8EaUhWvX8hIFbvD5+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElGk9gOe5v3xJSdhr0X6CqRQhl/kPqfkd0eXP2nNZYyG516q9ifkwqjcBqj9utZZ4dlW7Xgpk+kDZoPgdiIkxjlW4YilI9HGXHbsJ8esEv6+FTN4pmjfHbWQkxU+Xts91wnPZOyWxL83Nk64qeUTAuGjv1a3p1ndvYPfsnICfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mYellDbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A701C116D0;
	Wed, 25 Feb 2026 01:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982856;
	bh=KztvUChYH4qoBTwo76/6FhE6p8EaUhWvX8hIFbvD5+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYellDbAW2qv89qRKi+vlCfqsMZw9z8R2lFi7Yg4XEWUsg4iiuZHzrL82OSvYxxAn
	 /0pax9IOjq15QQ+ubtnkl4IoQQmT3OjGGQnRh4lBU/mfc0i8UnAG5w6WacokaBK4wM
	 zM6gqhF1AIc/uErUIaV6tlAp8R5UYVbigJ2+m4NU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 045/781] thermal: intel: x86_pkg_temp_thermal: Handle invalid temperature
Date: Tue, 24 Feb 2026 17:12:34 -0800
Message-ID: <20260225012400.809379492@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218083-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 553CA18EC0C
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 9635c586a559ba0e45b2bfbff79c937ddbaf1a62 ]

After commit be0a3600aa1e ("thermal: sysfs: Rework the handling of trip
point updates"), THERMAL_TEMP_INVALID can be passed to sys_set_trip_temp()
and it is treated as a regular temperature value there, so the sysfs
write fails even though it is expected to succeed and disable the given
trip point.

Address this by making sys_set_trip_temp() clear its temp variable when
it is equal to THERMAL_TEMP_INVALID.

Fixes: be0a3600aa1e ("thermal: sysfs: Rework the handling of trip point updates")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2815400.mvXUDI8C0e@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 3fc679b6f11b1..aab5f9fca9c33 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -128,6 +128,9 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
 	u32 l, h, mask, shift, intr;
 	int tj_max, val, ret;
 
+	if (temp == THERMAL_TEMP_INVALID)
+		temp = 0;
+
 	tj_max = intel_tcc_get_tjmax(zonedev->cpu);
 	if (tj_max < 0)
 		return tj_max;
-- 
2.51.0




