Return-Path: <stable+bounces-234671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNkmCYmh1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:42:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2513C145E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AB0E301075B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5D2DCF41;
	Wed,  8 Apr 2026 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYlJZC7R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D66B67E;
	Wed,  8 Apr 2026 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673462; cv=none; b=MT9Fcz/yxJIIPo8fZhW/IVTCHriRuo80rKpf2QvMe7ZYY2rwM3Xk9ah7w5pNLeZOCaOq7NbWGMfy1Vcp4sgIvFb9nRv3Nes4ykFY3f+4bHYNyn+yU+kEL3FESnSij+284v9+QdNOIpBcXwdR/OkHBv3EZawyGzJBk0iYKez4wUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673462; c=relaxed/simple;
	bh=9arBt2M3d7Vbh5jXhv3/f3nIECU1XNnNUngP3XUsSho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAmelYgnfBgWTRkgj0ZygKNTg0kNi/gM6w44LAtSZDgl7D5GnJIRH5hsUtHsjlSDNZABstQCve4xZPVxgELKGg4n9c/A6rmMaFl8DmBkVxUsna/ZwzTsX/WToNDSg8Q9L96C9y6Grau2w7E/KWUNZuAT6gD61r0LbunYtF4RvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYlJZC7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7DDC19421;
	Wed,  8 Apr 2026 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673462;
	bh=9arBt2M3d7Vbh5jXhv3/f3nIECU1XNnNUngP3XUsSho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYlJZC7Rb9mvmVdSni5Ae0a0G8H0d0W/VY6oy4F2dvhoErVKrHPI5vOmYn9K7zbOZ
	 GIkLXO7I6myMInBPhzNFDWFmYEKB9+/5g7viyqhJdHPCQvgw8XZ3wUuqQ9+UrOSWdi
	 jKyKi/e8SK4PqVOJXzH6+vppBLp/K0x1EIM76iA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 6.18 241/277] thermal: core: Fix thermal zone device registration error path
Date: Wed,  8 Apr 2026 20:03:46 +0200
Message-ID: <20260408175942.859156889@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234671-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,arm.com:email]
X-Rspamd-Queue-Id: EF2513C145E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 9e07e3b81807edd356e1f794cffa00a428eff443 upstream.

If thermal_zone_device_register_with_trips() fails after registering
a thermal zone device, it needs to wait for the tz->removal completion
like thermal_zone_device_unregister(), in case user space has managed
to take a reference to the thermal zone device's kobject, in which case
thermal_release() may not be called by the error path itself and tz may
be freed prematurely.

Add the missing wait_for_completion() call to the thermal zone device
registration error path.

Fixes: 04e6ccfc93c5 ("thermal: core: Fix NULL pointer dereference in zone registration error path")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/2849815.mvXUDI8C0e@rafael.j.wysocki
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/thermal_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1638,6 +1638,7 @@ unregister:
 	device_del(&tz->device);
 release_device:
 	put_device(&tz->device);
+	wait_for_completion(&tz->removal);
 remove_id:
 	ida_free(&thermal_tz_ida, id);
 free_tzp:



