Return-Path: <stable+bounces-256192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDfKGqiqGGoomAgAu9opvQ
	(envelope-from <stable+bounces-256192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A02D5F9AF3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA1A430BAF0E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075A339866;
	Thu, 28 May 2026 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HAAypgpo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B71DE4E0;
	Thu, 28 May 2026 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001013; cv=none; b=E4vCu8t5z4YzECWJmu629OuC/QOXE29c8OO2NnpmrEZ97ho0ve1BOH/fgxQ5isUXu2R/V7I40+adljhYiDJInI5St8k1A7IL6EONuy5bZLk4+ia3hEBOPVkedY87UDxw/l9pXxafBy65gl9OAxFfmneWtX5vu4fCcMIX4MWtlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001013; c=relaxed/simple;
	bh=Yn5oixhCwPkMCneptFp6bsyyp/jRM2puwplT0536Cs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKMu/U9xq0HtRstpCwIv2nXHktJ6YwfVMezogN7Fxzy1nSEUrYUp5+bnR4PXNQH7M07a4li2b71mb/unMhzB2czZVyal+NK17KsemTb4elKiWjoEaUX6ELK8N8xFyuY5pATtdNlswYQUXIPUo6L0zVvs69f+bpg3bcuuFsAso88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HAAypgpo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04691F000E9;
	Thu, 28 May 2026 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001012;
	bh=nhYJtjNL5Zsch4x6KwKTFm2YElSEV8ITpKOTeut1c/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAAypgpongsoBlXweYw69hgflFUXHtvWCNLTCxxrPl7lXSBHIUaRUUvTVC9gWHfQ1
	 i4eJLUW8NC8+EFMdrrQ8xHRc3as+/DZrtjLuvaoSJ88AV+pyOJ73+jJuxeeU+1KJZj
	 Aj1t1CVIC+pMU93axKcFWKz4JejVIQlw7uLCqZhU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 212/272] HID: quirks: really enable the intended work around for appledisplay
Date: Thu, 28 May 2026 21:49:46 +0200
Message-ID: <20260528194635.158626087@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256192-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3A02D5F9AF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

[ Upstream commit 5f90dcfa8dc32a488581b78e575cdd7808ba5c78 ]

Commit c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for
appledisplay") intends to add a quirk for kernels built with Apple Cinema
Display support, but it refers to the non-existing config option
CONFIG_APPLEDISPLAY, whereas the config option for Apple Cinema Display
support is named CONFIG_USB_APPLEDISPLAY.

Refer to the intended config option CONFIG_USB_APPLEDISPLAY in the ifdef
directive.

Fixes: c7fabe4ad921 ("HID: quirks: work around VID/PID conflict for appledisplay")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index d9e33dde89899..9d396d2e534d0 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -234,7 +234,7 @@ static const struct hid_device_id hid_quirks[] = {
  * used as a driver. See hid_scan_report().
  */
 static const struct hid_device_id hid_have_special_driver[] = {
-#if IS_ENABLED(CONFIG_APPLEDISPLAY)
+#if IS_ENABLED(CONFIG_USB_APPLEDISPLAY)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 0x9218) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 0x9219) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, 0x921c) },
-- 
2.53.0




