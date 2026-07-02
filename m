Return-Path: <stable+bounces-270906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ABLBH3CWRmo6ZQsAu9opvQ
	(envelope-from <stable+bounces-270906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:48:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6486FA969
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:48:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rq0SKOyh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270906-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270906-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61E98307B08A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849A6360EED;
	Thu,  2 Jul 2026 16:36:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C433F59D;
	Thu,  2 Jul 2026 16:35:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010160; cv=none; b=sCIn2o0pwh9P7kzpBuWGErOXlz5il39BLG1NjUeIrIgjI1MTiV7xINluHT7fT+XYlWeAJRRgxakwhGk47IsU2CTV5QLQIp3IhIlN+EiN+eMyhgN9ipJ1cC9LAYoiZJLDLP+yNMRvZdUVVoX+le+AlugLmP9VZHcJeTwCLl/vZgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010160; c=relaxed/simple;
	bh=E5s/p/pwYQy+5lz1Jk+Qlc3AlueTebrXbeKnKXCWsFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSIlih9dsz0GsfiuYsy4FwQYicFB9J0B/QA0IDv3yhlOzTZaAUqkyYFOl82c+G3zhZ/WrUWsk+2wi6d68aYI6YHLYduAgvAMy+bIjNx93euOH+Zw44RhWZdhOiFcLToY64myTvagmLL8E2RWDrUy74ACkPZH2ANCeiT60rW4vAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rq0SKOyh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25BF1F000E9;
	Thu,  2 Jul 2026 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010159;
	bh=OT8puXY6sJwbk1Izj+Fs/7gYnPpWu4WLZFTScvKk4Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rq0SKOyheoFnQo4dcK7M+AhK2ymT22mc1Wyng57HTlhj78jsERtd9/4DNX/JjLgtS
	 UHBtQY5IHCtELcz39NTWR5lzI4Zl7HyR6ezdZmkw/HBZTF1q12ivmQCMjMAeTXZLNm
	 grvYd1xukaSrCuS/pmhI3N7GK8Zjqd4UCvc+6z+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Deepak Kumar Singh <quic_deesin@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 111/129] rpmsg: char: Add lock to avoid race when rpmsg device is released
Date: Thu,  2 Jul 2026 18:20:30 +0200
Message-ID: <20260702155114.440361596@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.163984240@linuxfoundation.org>
References: <20260702155112.163984240@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270906-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:quic_deesin@quicinc.com,m:andersson@kernel.org,m:wen.yang@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quicinc.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE6486FA969

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepak Kumar Singh <quic_deesin@quicinc.com>

commit 17b88a2050e9d1f89a53562f2adb709a8959e763 upstream.

When remote host goes down glink char device channel is freed and
associated rpdev is destroyed through rpmsg_chrdev_eptdev_destroy(),
At the same time user space apps can still try to open/poll rpmsg
char device which will result in calling rpmsg_create_ept()/rpmsg_poll().
These functions will try to reference rpdev which has already been freed
through rpmsg_chrdev_eptdev_destroy().

File operation functions and device removal function must be protected
with lock. This patch adds existing ept lock in remove function as well.

Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/1663584840-15762-2-git-send-email-quic_deesin@quicinc.com
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rpmsg/rpmsg_char.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -75,6 +75,7 @@ int rpmsg_chrdev_eptdev_destroy(struct d
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
 
 	mutex_lock(&eptdev->ept_lock);
+	eptdev->rpdev = NULL;
 	if (eptdev->ept) {
 		/* The default endpoint is released by the rpmsg core */
 		if (!eptdev->default_ept)
@@ -128,6 +129,11 @@ static int rpmsg_eptdev_open(struct inod
 		return -EBUSY;
 	}
 
+	if (!eptdev->rpdev) {
+		mutex_unlock(&eptdev->ept_lock);
+		return -ENETRESET;
+	}
+
 	get_device(dev);
 
 	/*
@@ -279,7 +285,9 @@ static __poll_t rpmsg_eptdev_poll(struct
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	mutex_lock(&eptdev->ept_lock);
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
+	mutex_unlock(&eptdev->ept_lock);
 
 	return mask;
 }



