Return-Path: <stable+bounces-247673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM3XNJkGB2p+qwIAu9opvQ
	(envelope-from <stable+bounces-247673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:42:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981254EA42
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02FB0304D8C0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695AD47B41F;
	Fri, 15 May 2026 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI0GcDGO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9D47A0C7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844753; cv=none; b=ElFf/m10g6vNyfDt2rB2Yi13GjunoGfWipK37VKJob6VPg3FjRS5175YgA9OsruEw4MSUErvAy+HQUZMzEZdin5ObX5jtmkkFUdCyLDf8yino6AhjhrpRjeuX4MShgfJcNonHn5DqZAk7kZAgUYhiu8DgwI9LwSFimGznkZQVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844753; c=relaxed/simple;
	bh=PxM5b/63DgY1mPP+e++ie80OPk9nasWm5oAvhbSgfqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHWiRUIG34mzSaNV35n2GMFQUU1zpYY57bKWIzFJZhPR09l5lEmEh5uILqrZWxZfarY+gtlbUVYJOPduBSQjlY6wx9L6JTZtGdzspaaVi2xDgbrSQFVOOVTTcY5kG0MW4XLEMs07Gr9BzS+ovWVZH5geHsa9WUZSag25Q+Wa7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI0GcDGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B56C2BCB0;
	Fri, 15 May 2026 11:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844752;
	bh=PxM5b/63DgY1mPP+e++ie80OPk9nasWm5oAvhbSgfqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qI0GcDGOe0+VHcXNjVvoZk8oO7GjzTuFDqD6+LVzUYFYy7ZRImqQLVeRh43+PGLM5
	 mKuVQ2eJCENv6x0N6gIOZ9oyTdtFGs0BauzwbckZlDwkZI4v9wZ8+SAlZWgPOtGt0a
	 fIxuKfbFvCPA7aC9b6JjmyvAnKImd8xbVU8kom2M5byKznmB6/tAibayO2dcaDHrya
	 rIFgDab4GEjDhnDchvJ2JpICOpv6RFzHcvuIjcJx8ENLsVYLE+5sa8lUMdYQzEuJu7
	 /EmIoyurRLKDTdaLyWsrfL8nUiu4fWVMOCW88ZVNIEj01PjxCsA4fOPpQLZqKtflQU
	 uzUMqK9SKuIOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] thermal: core: Free thermal zone ID later during removal
Date: Fri, 15 May 2026 07:32:29 -0400
Message-ID: <20260515113229.2980491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051205-extruding-shrunk-88ff@gregkh>
References: <2026051205-extruding-shrunk-88ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7981254EA42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247673-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit daae9c18feec74566e023fc88cfb0ce26e39d868 ]

The thermal zone removal ordering is different from the thermal zone
registration rollback path ordering and the former is arguably
problematic because freeing a thermal zone ID prematurely may cause
it to be used during the registration of another thermal zone which
may fail as a result.

Prevent that from occurring by changing the thermal zone removal
ordering to reflect the thermal zone registration rollback path
ordering.

Also more the ida_destroy() call from thermal_zone_device_unregister()
to thermal_release() for consistency.

Fixes: b31ef8285b19 ("thermal core: convert ID allocation to IDA")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/5063934.GXAFRqVoOG@rafael.j.wysocki
[ moved ida_simple_remove(&thermal_tz_ida) to after device_unregister() and relocated ida_destroy(&tz->ida) into thermal_release() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 1cf49912dc96c..069bed335a6fd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -986,6 +986,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		ida_destroy(&tz->ida);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1574,11 +1575,11 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
-	ida_simple_remove(&thermal_tz_ida, tz->id);
-	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
+	ida_simple_remove(&thermal_tz_ida, tz_id);
+
 	thermal_notify_tz_delete(tz_id);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
-- 
2.53.0


