Return-Path: <stable+bounces-33283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C46891A6F
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4071CB25B55
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CFE158DD3;
	Fri, 29 Mar 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYvKpgwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC513E6B6;
	Fri, 29 Mar 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715504; cv=none; b=gsbA6cBlRIjBjT7hEvN+ESo65akGASdhm2puqQE66hT1owti6nrDxtm90xd5w0jIeCs5Nbd+Ur4lcPpCjcnlkjIQHcZk3SqRq51NoKetccd3Vtfs4hPsb6Byw6Ofo/u07MLNK/p0srGABh5uB99uUOM/1kwWKcLuLwazncoRP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715504; c=relaxed/simple;
	bh=OpIpmwQP3y7vkF2hLh+CR15WHSbQIVtwxC+Xpy/O1nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2QSSmD7UczR6Yg0YJKGQyCGVhPW5pl4+AnxbW0F349vAOWDCLUcFAbQSkLcJ24xNrdoVqaFkv4WmkM1/KVHXV/zwyCkNEMpC81vUDzJtxDgO41v+J+sH0IF9CoIIVu+cSh0qpDx+UyZs7G/Qw4IqQ4ZvRAuHotMDmBVA4AForQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYvKpgwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5650FC433B2;
	Fri, 29 Mar 2024 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715504;
	bh=OpIpmwQP3y7vkF2hLh+CR15WHSbQIVtwxC+Xpy/O1nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYvKpgwaiZrFKjPRykNJkXYEE/WyunrE4xf1IsaKplksZIQ8ovqCedYJrXG4JZDZD
	 JWC/JVD0k3nJ1fPnH8WRc2amuYpWZJ+OPGGfE2RMvf9aywxms3fgrodEmYzOl41Orv
	 97+ey7ji/aRPC6ubKZtVQWas8TqDkV4P8p53kOeF2HGy8H/NLIL2G5KruSH9TCazeV
	 655CAeUDPhI+oGl+9mgJw0db0I7XKOuQ/DzV9XDmWcmXn6DNEt92JOODc3yZmxxlty
	 0D1AAYqwDyao+CINKloz+rKc3a3glk/41MjMVupD+sNHxQn6V4NlGJheRVVwygtLk2
	 yvjNr3+/zyw2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 50/52] Bluetooth: btintel: Fix null ptr deref in btintel_read_version
Date: Fri, 29 Mar 2024 08:29:20 -0400
Message-ID: <20240329122956.3083859-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit b79e040910101b020931ba0c9a6b77e81ab7f645 ]

If hci_cmd_sync_complete() is triggered and skb is NULL, then
hdev->req_skb is NULL, which will cause this issue.

Reported-and-tested-by: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2462796a512a5..b396b0b1d6cc2 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -435,7 +435,7 @@ int btintel_read_version(struct hci_dev *hdev, struct intel_version *ver)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
 		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
-- 
2.43.0


