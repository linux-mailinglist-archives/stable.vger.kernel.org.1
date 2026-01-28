Return-Path: <stable+bounces-212359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCZaINMwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C9A49F3
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3522308E823
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752F2D3EC7;
	Wed, 28 Jan 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEB6pdPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB6430F555;
	Wed, 28 Jan 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615256; cv=none; b=PHRczBnb+lizU7iL+X2+12/ok4ye5+1LG6OuZSwdt9UgFcksBxCg4JyO9jRiEyhEdjq3JIi/3PDd1YkykC8Mh3F6Tq6W8z/2BE/WHsT8foqVOHE+ayWImVOukTIxO17UGq8FPdYQ+nqw8sPAw+j2Wm6cpCUSo5x+6lvqoep7/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615256; c=relaxed/simple;
	bh=L5NZj+j9uX5+EiqzZ2GS3Sp2kH7vxOQJJdtoba0Aowk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcYHdaDzrgcaRYZxJPpJ06xJwldt5XAuqhCSVB9WiE+9v0BTLQ3Z32LdVMGOUSFYuVsdDtwkzK07nDRPkzlak3l4CEtgULhmzll3Jt28rJlMCLUmUq6QyDAfzLVFR63JT8pyJUAugZgo2XtG/gUZD/X6+8cnYDAeirvUNlQY5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VEB6pdPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4528FC4CEF1;
	Wed, 28 Jan 2026 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615256;
	bh=L5NZj+j9uX5+EiqzZ2GS3Sp2kH7vxOQJJdtoba0Aowk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEB6pdPHddIMG0Y24174YQx9B6iO2/LQAs0ypYN5oswn68hErw2OsT7eEgj2tFyHQ
	 DmjDP0B+O9GM6TUGDnee4hN6igwk4yh4CbOPl2Il7jr/3mVKJuKFfEWWTff/YjWbSY
	 c7n9ZxavawLcbNIQWzr9GkpL8B5VCT+onkuPVa+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.12 125/169] slimbus: core: fix device reference leak on report present
Date: Wed, 28 Jan 2026 16:23:28 +0100
Message-ID: <20260128145338.506940615@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212359-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D98C9A49F3
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 9391380eb91ea5ac792aae9273535c8da5b9aa01 upstream.

Slimbus devices can be allocated dynamically upon reception of
report-present messages.

Make sure to drop the reference taken when looking up already registered
devices.

Note that this requires taking an extra reference in case the device has
not yet been registered and has to be allocated.

Fixes: 46a2bb5a7f7e ("slimbus: core: Add slim controllers support")
Cc: stable@vger.kernel.org	# 4.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251126145329.5022-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/slimbus/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -378,6 +378,8 @@ struct slim_device *slim_get_device(stru
 		sbdev = slim_alloc_device(ctrl, e_addr, NULL);
 		if (!sbdev)
 			return ERR_PTR(-ENOMEM);
+
+		get_device(&sbdev->dev);
 	}
 
 	return sbdev;
@@ -512,6 +514,7 @@ int slim_device_report_present(struct sl
 		ret = slim_device_alloc_laddr(sbdev, true);
 	}
 
+	put_device(&sbdev->dev);
 out_put_rpm:
 	pm_runtime_mark_last_busy(ctrl->dev);
 	pm_runtime_put_autosuspend(ctrl->dev);



