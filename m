Return-Path: <stable+bounces-213663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K6IIm5jg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:19:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB48E846B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8CF830C7906
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEDF42189C;
	Wed,  4 Feb 2026 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u49YACvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2189421899;
	Wed,  4 Feb 2026 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217089; cv=none; b=J69FmRSO6COV8so/0iVokInIas2ADJpCcrm9WJeUQAqQ8WWnYLGaAFIjf/qH03aA2vfB3i+gEzk+aGZJJa2hHWG3N7096/iBQKJIvmTFTAVCYPlEmKkoaoPX7yvVvVS9i0s2Yo4YKICJ1hfLcyvYF0+0JlLYCktveb7Ed04GlUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217089; c=relaxed/simple;
	bh=jIGp2jBsRzN1cAo5ciQrFBbIRBzMgQpPm51sNu9f2X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwHNDeNIBqLNPIChlzrOfULw658kQA+n/1RD10SEwcMaDV2EvsOhQhCE2A9r67WjncHoz4Skbp/7BqgMEzZEhbEARYgQm5FV+q2l4RNrfOEmBXgwp7eI6Yo6b/lYLKQWvYJTmZQp3kwxgk8eNirQ14OYHBCozBPdbYcXA8p/Vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u49YACvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D8EC4CEF7;
	Wed,  4 Feb 2026 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217089;
	bh=jIGp2jBsRzN1cAo5ciQrFBbIRBzMgQpPm51sNu9f2X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u49YACvnFB1ArWLUeqC6XeUdUs9ejXpIql3Sop6IW5x1aIxkE06GGfGZi9lUacw3B
	 ogc6+7N9vVXRLgMS3Xk6cBwhlwl4ROLwN5uVJSb+Ks8YhWBuse7qfKoFRO7xzEQEP1
	 1H+Ufdu1cKTtMMJlz0RaMZS6rscocaWYb5vyJ4QY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.15 120/206] slimbus: core: fix device reference leak on report present
Date: Wed,  4 Feb 2026 15:39:11 +0100
Message-ID: <20260204143902.523504300@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213663-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: EBB48E846B
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

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



