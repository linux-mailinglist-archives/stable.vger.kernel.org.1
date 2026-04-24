Return-Path: <stable+bounces-240976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIJ0Gdl562npNAAAu9opvQ
	(envelope-from <stable+bounces-240976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:10:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D13460094
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9E73059765
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E113DBD5F;
	Fri, 24 Apr 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxXR2Fm9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3E3DB641
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039693; cv=none; b=npu4GhGFQhN4MqjzgEwJYSwFY9Bm0Gd4+jHqzXlvpuoS7Nco2z9mbnLrliDD52XRE31nf8dcClN5hjXX/fec5mpgtt78oyq1WOlaazw2CA/J2IeskM/xvGSuLwqOLhFvVNHzAiavYJhkxBGSrHq2Si6kqhaXwgYkuAGYfx/TxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039693; c=relaxed/simple;
	bh=eqsoHMIOOabBLTi9Vt6IUu2GMKr3JRX0N3iuQ2xWg/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8bhgN6JQxNNrv1P84VcjMvK4mHBABaUj2KksSG83WtHuYI8g4QV+8rKK5Da4NrBNdD7vV62NRKNaL2sTeZfp3403rPQJ3aKYM/HtIPAsMv7kBq33OGTJk3ymqJAf0Bw7P1hvkFPq4Qc4kqlbTykGlcHe2a4Xfp+FvQM3UpzTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxXR2Fm9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so3612796b3a.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039690; x=1777644490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8i0Gpepc+zFweLSIN4Cg/R5ifn3iGWjVwE5PfxJUKQ=;
        b=fxXR2Fm9GUuCDlkvZ98tIX4UJXqKIU0OM7457fN6WTnN91K8CevFZkUZCywzcAN/QX
         7Hw1K+LSk/U5CWugbAjXXRnyqwjaRmhJFh4dmL1X2TPe0bcNalHnhioa5lcOOY3l5ze/
         3v/+P+Ejl+l9LZE2y+cAt/X18v3HxeKAtAOMXjP+i8dg1BJEIeFSDVTxMEXvuHJU7LQV
         Ms0bdLSIOPOimpoqPXuHk8iydvltF8Sq0hDq7/MIskvXbJNIYdEZ4da0cKBqmehtMU8H
         E1JqRBI1HQwwhi2fmz68tdBjsKMH6LXAGE5D1rkPdddQkdQP8XnM3kf6vHuEbTguU+5a
         e29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039690; x=1777644490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8i0Gpepc+zFweLSIN4Cg/R5ifn3iGWjVwE5PfxJUKQ=;
        b=tIFnRB8G/dkhi1824QVduvGG/oQQucX+Gq6/0rFF68jQTLGQBi7Z3s1MLcSgyEOgbz
         5xdXUpCSAbahoHyo9zaynsAauIM6FNnoAMxF8C7Fs8xnd+eWDXuUIAaAtenFzEb87ljX
         d5XfveSR2LYWRLE/c52xW/WEy0hDX81HxxaqIdq0NIWQPMWjUP8/X/B/5rk/UwSJ22+F
         BVuUbDRda6rhpT9TK6Y+6HK08CkyfpjW73lwaFp1uw7IGboWGMRlDvDinX87ilDBCqf5
         chJwaJeCwjGU9H43gZ0K5zTvnjQwF/DDT16KFOhiZf16I6NTINMl3v3ACLpWr06B6qIm
         FQVw==
X-Forwarded-Encrypted: i=1; AFNElJ8lFdkCiJ4/CmIqaegadKoJyZDNY5Q3WNsIpMrz1T16Suvep3ap0Uf0FWwCR+3ZPM+MvxNo7h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXjuKLID5IOZ5pm0mNluEkDUn4c4EsuTzip6RczDxVwx/1Sy2
	7eR6o+7VCCCagfmho1WTiCWuVemvwIF9pBFUgU86TB5c15gQq2JZQmE=
X-Gm-Gg: AeBDievkztab4bZTkZ9+2UmSnAa1XdkLUx2epfR313h4HgG2h+/AjUCxxReTRMB6oSt
	Gu/8nJgnL9cxRsduutmVQ/3uKx8qIeLjTWGlqlbypu04G4muKQxniGKIX+J/sJY5sFyLJDrbg5s
	3lW1ASqONwZkc4if4O/lET8l5F9/TzuPHLOG2ZnB2P88dHnRbTCoCsx7AfrUdCuCNsMLpdLaqxo
	ZtQHAjAHLThwGmcyZCFvdzxhjGQZ2aHDlrF33VKTHhfvzZXMExON54AAZYr0thtWhOTFDCNcKcp
	Z5Ckh+Td++NpMMjkZ++rlAx9ScumiVjuLD/6y7aMndO0eQv3CC+wP+38rUfC8NbnzD/incsUNmy
	/5KpbTQduOf29bSpMCk7Sy6YcNQczSArVgulU77RlqV2aTNNnSH9dmouY9eWJrf9g03lPlLwNz4
	FeYDD2lgyoD5WWb+360XsGF+Sh2HZTjb3TK4MXvOfPZtuJ2eocWrPcZoNEQhom2dkYHwWmTG0N9
	+fyzDVYYXID5PI=
X-Received: by 2002:a05:6a00:2d03:b0:82c:ebae:3cb with SMTP id d2e1a72fcca58-82f8c91924dmr33416449b3a.43.1777039690269;
        Fri, 24 Apr 2026 07:08:10 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm25404664b3a.20.2026.04.24.07.08.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 07:08:09 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: vd56g3: Clean up subdev state on probe failure
Date: Fri, 24 Apr 2026 23:07:41 +0900
Message-ID: <20260424140804.31568-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4D13460094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240976-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

vd56g3_subdev_init() calls v4l2_subdev_init_finalize(), which allocates
the subdev active state and requires v4l2_subdev_cleanup() to release it.

If vd56g3_update_controls() fails after finalize succeeds, the probe error
path currently skips v4l2_subdev_cleanup() and returns an error. The driver
.remove() callback is not called after a failed probe, so the active state
is leaked.

Route this error through a subdev cleanup label before freeing the control
handler and media entity.

Fixes: 87aa97fc3157 ("media: i2c: Add driver for ST VD56G3 camera sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/i2c/vd56g3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/vd56g3.c b/drivers/media/i2c/vd56g3.c
index 157acea9e2..43f792288a 100644
--- a/drivers/media/i2c/vd56g3.c
+++ b/drivers/media/i2c/vd56g3.c
@@ -1427,11 +1427,14 @@ static int vd56g3_subdev_init(struct vd56g3 *sensor)
 	v4l2_subdev_unlock_state(state);
 	if (ret) {
 		dev_err(sensor->dev, "Controls update failed: %d\n", ret);
-		goto err_ctrls;
+		goto err_subdev;
 	}
 
 	return 0;
 
+err_subdev:
+	v4l2_subdev_cleanup(&sensor->sd);
+
 err_ctrls:
 	v4l2_ctrl_handler_free(sensor->sd.ctrl_handler);
 
-- 
2.50.1

