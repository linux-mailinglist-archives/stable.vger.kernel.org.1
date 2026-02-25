Return-Path: <stable+bounces-218871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB1jC2VZnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:07:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 859B819092A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C4932B078F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DA9276049;
	Wed, 25 Feb 2026 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6fCymVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A226056D;
	Wed, 25 Feb 2026 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983757; cv=none; b=OSZZWLdHbFVzeCwS+KGxcs6zlhhpudZT+7B5L1+anS+dsmvxP8OGDBhXrGXhc1z1lCLMbHRMhtBH/26KB21ua6A0QK+5jjJ8xYvTd/akhfxM5K9SpnYcKs0qU+DiEcCruqJ9Hokp5XWfUEpr8g+OBp5NhTRuFc0TKbp5qIWtJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983757; c=relaxed/simple;
	bh=XVS/m8cVHoyYODctXBp1CHYb7ijEufs5faN/U/aCabo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Om4CYc0JxDl4Tzk1GOZHyAx00WZ/lDGunhAE2pbz15lrn0x8b4X+gZr2U7TRH+RCyAdeCeRg+xBhiJqHvV5o4qZYXEZmUTDQC/132pHMHcivef0SZOcx7B+YevBsDUGU6298dLsEgK+T+zm2yONh+c+rg1LoqFoOzQG35FBoBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6fCymVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6223CC116D0;
	Wed, 25 Feb 2026 01:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983757;
	bh=XVS/m8cVHoyYODctXBp1CHYb7ijEufs5faN/U/aCabo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6fCymVqwEkXNgW33yvjlFbR9oPwLrSgNykddm8FtmSSlRmqeiCPNTKESdtcQ4TEc
	 uVlRWGSe0Bl3Wfh2BLBlx0gCyT501/QvPsUEyC8jtfgLr2HdiFCwspkYBjJT0lWeTE
	 xaABfyrI2C5+ZwTQ8MRe/awZMJIXtpWQxc1niYyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 042/641] thermal: intel: x86_pkg_temp_thermal: Handle invalid temperature
Date: Tue, 24 Feb 2026 17:16:08 -0800
Message-ID: <20260225012350.043390689@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218871-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 859B819092A
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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




