Return-Path: <stable+bounces-220785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cQByF+BBo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:28:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB951C7084
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AE9E309FBA8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5234240A911;
	Sat, 28 Feb 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdMCoolS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152463630BB;
	Sat, 28 Feb 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300669; cv=none; b=SjgIunLjwha9rpId+H/f1soY8n4IK5K42+rpgu18SHlhAF3Q1/QPuqh5bqK3s0N/2C5FQSM8iDCJHNI7y9+VErKIgJKiqsfklOX+IeJ+LGhji7TZA623qCWvjaZmKWQT3YVnJLm2WgwI7DlBR7bwF1oiYN4lqM3zNzXSRg8AB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300669; c=relaxed/simple;
	bh=5DCS3A7t+tTiclp/u9V8WFYtNQXqWmziwsQZxT7F0Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgW+ENLUVR6mNZofit7dVYkW/Yi1S39EP63MgkSmMtIxipK4Ykk97xcG9QneRLYhy+1Lp7XNWY26En4nG7WEkBwuHWu6OGXu+nL7fzcw5fkzQN9UAmrlpdVHS1Hf4MeJD0DCgI3LnFY3cgQpVzmCnV+YWbJcWYDfSkGC/L0hdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdMCoolS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F711C116D0;
	Sat, 28 Feb 2026 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300669;
	bh=5DCS3A7t+tTiclp/u9V8WFYtNQXqWmziwsQZxT7F0Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdMCoolS5Mn6G7fCnTX3fxSKg1IAZk5TotoiybMOhA6mNtRmkLep0t9or+b66ctIB
	 4oOoQCuaQkedpyVwJ0ekwCSHs9R2zBY6XNFbVvEKQrz8ZBe5YK5esXsndsBB/RiHFW
	 HYSgNZ3OVgBl8Wv2JYArqo+/AYS98w34uSzCWkDwIQbZDX+ohPfgXDZC6zpBKVCRp+
	 GCA3aX1kzQyQBQjiFyqfOHvYR5ACFzFnlTl8IgBVdcGR/e6Eoa/S8vxlkVrbp5cpT8
	 JBotM2alN0iPy4BWMjLEeUnQSd4w2042KG6MtatIJAr0J9KPfOJaiVNg5CeharNgLH
	 vnOQHfgoZP3qA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 706/844] dm mpath: Add missing dm_put_device when failing to get scsi dh name
Date: Sat, 28 Feb 2026 12:30:19 -0500
Message-ID: <20260228173244.1509663-707-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220785-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFB951C7084
X-Rspamd-Action: no action

From: Benjamin Marzinski <bmarzins@redhat.com>

[ Upstream commit 787bd63ee661b0148ce8e1fde92b7afddd85c446 ]

When commit fd81bc5cca8f ("scsi: device_handler: Return error pointer in
scsi_dh_attached_handler_name()") added code to fail parsing the path if
scsi_dh_attached_handler_name() failed with -ENOMEM, it didn't clean up
the reference to the path device that had just been taken. Fix this, and
steamline the error paths of parse_path() a little.

Fixes: fd81bc5cca8f ("scsi: device_handler: Return error pointer in scsi_dh_attached_handler_name()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-mpath.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index d5d6ef7ba8381..b739894f01807 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -960,27 +960,27 @@ static struct pgpath *parse_path(struct dm_arg_set *as, struct path_selector *ps
 			attached_handler_name = NULL;
 		} else {
 			r = PTR_ERR(attached_handler_name);
-			goto bad;
+			ti->error = "error allocating handler name";
+			goto bad_put_device;
 		}
 	}
 	if (attached_handler_name || m->hw_handler_name) {
 		INIT_DELAYED_WORK(&p->activate_path, activate_path_work);
 		r = setup_scsi_dh(p->path.dev->bdev, m, &attached_handler_name, &ti->error);
 		kfree(attached_handler_name);
-		if (r) {
-			dm_put_device(ti, p->path.dev);
-			goto bad;
-		}
+		if (r)
+			goto bad_put_device;
 	}
 
 	r = ps->type->add_path(ps, &p->path, as->argc, as->argv, &ti->error);
-	if (r) {
-		dm_put_device(ti, p->path.dev);
-		goto bad;
-	}
+	if (r)
+		goto bad_put_device;
 
 	return p;
- bad:
+
+bad_put_device:
+	dm_put_device(ti, p->path.dev);
+bad:
 	free_pgpath(p);
 	return ERR_PTR(r);
 }
-- 
2.51.0


