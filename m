Return-Path: <stable+bounces-220658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCBUGvJRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:37:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E01C8726
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12ED1321C4D1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591C3F26A6;
	Sat, 28 Feb 2026 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gECU2FZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C63F1BAA;
	Sat, 28 Feb 2026 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300539; cv=none; b=O9nl4dw3mqIL+EK3IOQqZoE1s2CTWkuHOzpEHHKrVk2YUCfrCODVnpBRwSdr9FqQ4EUoUMep4odmnV28JUA1q6C8B6XRdOOaxM73q8LQmOE1OOLbsyJ6tPYW/jdZfwcEjNQeghGrTjx8VAY8LWenUzx1I7nD2qXMb2o5FrvpfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300539; c=relaxed/simple;
	bh=9XiW3GpYli+WyXCsoXLNbi7jTatj6HD3MPaVz1E9SBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbrvwSbx3STwySp55nMx28h89AggYcgNsRrajDBoSg5m6AMOvL+cqlDlsgSVEWhPDPuSymjPDxB2QukJ+nRXgMwhbrZZop3OyzZVJ2JgFW6DggpKcBnxNr7ttxPqp9CcBzQN1PRHTKZ9aVD0VtotI6Crm9/3BN8bbZQv527OpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gECU2FZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4B8C19423;
	Sat, 28 Feb 2026 17:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300539;
	bh=9XiW3GpYli+WyXCsoXLNbi7jTatj6HD3MPaVz1E9SBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gECU2FZDF7glxGL0iED6I5ACOEI2Ti3p1FMTP08eoMDrKx1BFS3U4i3ZbqCe4/yfg
	 vPHxeNQCXxa4aVPnTNqfsSG2WMYmCj8/3lVxx0LjfRmbxo9AGlQhroc909B9docA7D
	 Oq3WxFXZkHqSnTbLpcXOfnY8rucNswWLjZeDjdAUWqQzkyir9GWM0Ex6fO84KDsGwW
	 Ywb6S2sR6u6lbdUQt06KD/tLfCzCx292lz8yTiJmRPdwnMoXet8ntrpgzVJQKFbXXb
	 TWYexZMHtxwu19912upFHh8KLmeowB/eNp1Aw69LCGo+Ro8Gz10RXyiaqz8nfBHFlV
	 bdRwwWqrM5sfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 579/844] media: i2c: ov01a10: Add missing v4l2_subdev_cleanup() calls
Date: Sat, 28 Feb 2026 12:28:12 -0500
Message-ID: <20260228173244.1509663-580-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220658-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B09E01C8726
X-Rspamd-Action: no action

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit 0dfec6e30c334364145d0acb38bb8c216b9a7a78 ]

Add missing v4l2_subdev_cleanup() calls to cleanup after
v4l2_subdev_init_finalize().

Fixes: 0827b58dabff ("media: i2c: add ov01a10 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov01a10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
index 834ca46acb75f..1e22df12989ae 100644
--- a/drivers/media/i2c/ov01a10.c
+++ b/drivers/media/i2c/ov01a10.c
@@ -864,6 +864,7 @@ static void ov01a10_remove(struct i2c_client *client)
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 
 	v4l2_async_unregister_subdev(sd);
+	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 
@@ -934,6 +935,7 @@ static int ov01a10_probe(struct i2c_client *client)
 err_pm_disable:
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(&client->dev);
+	v4l2_subdev_cleanup(&ov01a10->sd);
 
 err_media_entity_cleanup:
 	media_entity_cleanup(&ov01a10->sd.entity);
-- 
2.51.0


