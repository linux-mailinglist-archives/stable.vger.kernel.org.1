Return-Path: <stable+bounces-220261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lt8NR4vo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9101C5734
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68A0320AF8F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90737D78E;
	Sat, 28 Feb 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JneeB8i3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10237D785;
	Sat, 28 Feb 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300164; cv=none; b=B3B28Z7GkPS1WCM0LbEGAFSZdaCWjA/yC5IxCx13uX8/ndX0BqDC20pXyW6GKK3+O8S5Mvub3BQsgJpw+0cmAmuQQoPmS8xPnd8W4+gAV71FnsSsig/BnLMWFuJ05aN6gYbgAqmP5pHRT8D14+CKnjFCJIbye6g7jIHN7Gbe52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300164; c=relaxed/simple;
	bh=7Ai5J78US4WCWcSIRNjDnWgArYAcRIXbS/AvosGatCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2+ksEVdk3+yh+O0smj5lnmN/M9az/U/HKXPUnZBpMew60hMnD8d2H6josgZo3XktcQ5rDqQo8aVUZv8fycpmCJFCdIslPdeOic2o1m/xdybCkb7FxgF4wnQBbjkCEWb16EyAk5dTzFxEgsNP8YdoI0MuhxA+jlcVtEO6US+0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JneeB8i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A14C116D0;
	Sat, 28 Feb 2026 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300164;
	bh=7Ai5J78US4WCWcSIRNjDnWgArYAcRIXbS/AvosGatCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JneeB8i3fPRibOYE+G/VG/XHgMafBL2fc9gt8GC9y9OvHeNaka1Ugdm9s2doquC07
	 R9N6LktihtZaUsBbh0xumNL6EMpy2QIPDZcWiGgWZLEbmXiIwhSDn4Dj/dm0YkLAS5
	 1Prx/UWdGRkaDDRa5n+4klh4MKnnUkGTOUhF4VVYbhYkMf2DngN2kjpD1+KfsJ6AeI
	 L8KDfUtW7P10QjLlHzNygJ9AqI6H7ZAKqHRfafZJgx699Ut2oBahlqlc8zJb4vQDez
	 YPBBZGpeeqlE4t09rbhK0AQJu5NRi3IK5olsXfiwxnbBgEFO8LGiKdaNevwB3BzG6J
	 UWucalHExa6gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Yew, Chang Ching" <chang.ching.yew@intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 183/844] media: v4l2-async: Fix error handling on steps after finding a match
Date: Sat, 28 Feb 2026 12:21:36 -0500
Message-ID: <20260228173244.1509663-184-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220261-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D9101C5734
X-Rspamd-Action: no action

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 7345d6d356336c448d6b9230ed8704f39679fd12 ]

Once an async connection is found to be matching with an fwnode, a
sub-device may be registered (in case it wasn't already), its bound
operation is called, ancillary links are created, the async connection
is added to the sub-device's list of connections and removed from the
global waiting connection list. Further on, the sub-device's possible own
notifier is searched for possible additional matches.

Fix these specific issues:

- If v4l2_async_match_notify() failed before the sub-notifier handling,
  the async connection was unbound and its entry removed from the
  sub-device's async connection list. The latter part was also done in
  v4l2_async_match_notify().

- The async connection's sd field was only set after creating ancillary
  links in v4l2_async_match_notify(). It was however dereferenced in
  v4l2_async_unbind_subdev_one(), which was called on error path of
  v4l2_async_match_notify() failure.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: "Yew, Chang Ching" <chang.ching.yew@intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 45 +++++++++++++++++++---------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index ee884a8221fbd..1c08bba9ecb91 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -343,7 +343,6 @@ static int v4l2_async_match_notify(struct v4l2_async_notifier *notifier,
 				   struct v4l2_subdev *sd,
 				   struct v4l2_async_connection *asc)
 {
-	struct v4l2_async_notifier *subdev_notifier;
 	bool registered = false;
 	int ret;
 
@@ -389,6 +388,25 @@ static int v4l2_async_match_notify(struct v4l2_async_notifier *notifier,
 	dev_dbg(notifier_dev(notifier), "v4l2-async: %s bound (ret %d)\n",
 		dev_name(sd->dev), ret);
 
+	return 0;
+
+err_call_unbind:
+	v4l2_async_nf_call_unbind(notifier, sd, asc);
+	list_del(&asc->asc_subdev_entry);
+
+err_unregister_subdev:
+	if (registered)
+		v4l2_device_unregister_subdev(sd);
+
+	return ret;
+}
+
+static int
+v4l2_async_nf_try_subdev_notifier(struct v4l2_async_notifier *notifier,
+				  struct v4l2_subdev *sd)
+{
+	struct v4l2_async_notifier *subdev_notifier;
+
 	/*
 	 * See if the sub-device has a notifier. If not, return here.
 	 */
@@ -404,16 +422,6 @@ static int v4l2_async_match_notify(struct v4l2_async_notifier *notifier,
 	subdev_notifier->parent = notifier;
 
 	return v4l2_async_nf_try_all_subdevs(subdev_notifier);
-
-err_call_unbind:
-	v4l2_async_nf_call_unbind(notifier, sd, asc);
-	list_del(&asc->asc_subdev_entry);
-
-err_unregister_subdev:
-	if (registered)
-		v4l2_device_unregister_subdev(sd);
-
-	return ret;
 }
 
 /* Test all async sub-devices in a notifier for a match. */
@@ -445,6 +453,10 @@ v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier)
 		if (ret < 0)
 			return ret;
 
+		ret = v4l2_async_nf_try_subdev_notifier(notifier, sd);
+		if (ret < 0)
+			return ret;
+
 		/*
 		 * v4l2_async_match_notify() may lead to registering a
 		 * new notifier and thus changing the async subdevs
@@ -829,7 +841,11 @@ int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module)
 			ret = v4l2_async_match_notify(notifier, v4l2_dev, sd,
 						      asc);
 			if (ret)
-				goto err_unbind;
+				goto err_unlock;
+
+			ret = v4l2_async_nf_try_subdev_notifier(notifier, sd);
+			if (ret)
+				goto err_unbind_one;
 
 			ret = v4l2_async_nf_try_complete(notifier);
 			if (ret)
@@ -853,9 +869,10 @@ int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module)
 	if (subdev_notifier)
 		v4l2_async_nf_unbind_all_subdevs(subdev_notifier);
 
-	if (asc)
-		v4l2_async_unbind_subdev_one(notifier, asc);
+err_unbind_one:
+	v4l2_async_unbind_subdev_one(notifier, asc);
 
+err_unlock:
 	mutex_unlock(&list_lock);
 
 	sd->owner = NULL;
-- 
2.51.0


