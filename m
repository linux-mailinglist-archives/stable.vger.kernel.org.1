Return-Path: <stable+bounces-94992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737D9D7209
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C581A163762
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6EF1EBFE2;
	Sun, 24 Nov 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3nmLBFB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A701EABD9;
	Sun, 24 Nov 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455520; cv=none; b=sMBVP/NQ4hf0BtK8LfrAR2hfvxkynVjyClxbnzUqtMl1vBN+I4VJj1euHwTJ4urGVIdUYheBx7a+vksUWab4f+vOg7HAag8SEAiFI4DiBGlnNfFFX/iV25KaCqvIdZvUWNwrggY5dzzQASLpZM+JttXGwFjyg07AHIRflwu8W5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455520; c=relaxed/simple;
	bh=Q7+FMAp4L8D5Gqhw4A9duoOOq6TTqMpicGi4OlX82xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGhaldEtZj2ukprdSWPR6ncf69WEcOgBPBjMNisuW2DM+yyGsASwxUcBS0SLOuRULcCc5bZeeGkwrt4UO9HuDFr2k2KLcZy5HVtVrxrgEoTkaZYmboZr8TaKcI9czIXbYTfMg258k3XEqnhF+H4t3aO0LrmZROnw0HFGC48u5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3nmLBFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7ABC4CED6;
	Sun, 24 Nov 2024 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455520;
	bh=Q7+FMAp4L8D5Gqhw4A9duoOOq6TTqMpicGi4OlX82xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3nmLBFBmNqGUftmUjspE2lv2au5zMJwiUUfR8iU2jR2f6IKWwX4cxOIPfDnKFeyF
	 +nuXJ+lFqIMJWxSCWkEAnAj8LAvsK/V3RwsCSH3nOzLOl+LmoKMMhi07Gg6ahugB8d
	 nF8GCrgfEx0YVwDslf+O7BTIguwvAafdgkkue95RiKYPqaeXlfXsrAkDXsRj6qtnyN
	 Ri+qVTaPCgXhbbWwIHtuq6+5CQrIbfDml5ANgT4gekhYysdeDeSKLIgqHUmqYJ6fRQ
	 UqYfsD0y5sCvQ0SsNut7658duqrclhuBjahKHTUiZxyx7/L46zxYf7zpKdViXKSRIz
	 eBwVZdmyBay6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 096/107] Bluetooth: hci_conn: Use disable_delayed_work_sync
Date: Sun, 24 Nov 2024 08:29:56 -0500
Message-ID: <20241124133301.3341829-96-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 2b0f2fc9ed62e73c95df1fa8ed2ba3dac54699df ]

This makes use of disable_delayed_work_sync instead
cancel_delayed_work_sync as it not only cancel the ongoing work but also
disables new submit which is disarable since the object holding the work
is about to be freed.

Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Tested-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 50e65b2f54ee6..40c4a36d2be3f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1127,9 +1127,9 @@ void hci_conn_del(struct hci_conn *conn)
 
 	hci_conn_unlink(conn);
 
-	cancel_delayed_work_sync(&conn->disc_work);
-	cancel_delayed_work_sync(&conn->auto_accept_work);
-	cancel_delayed_work_sync(&conn->idle_work);
+	disable_delayed_work_sync(&conn->disc_work);
+	disable_delayed_work_sync(&conn->auto_accept_work);
+	disable_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
 		/* Unacked frames */
-- 
2.43.0


