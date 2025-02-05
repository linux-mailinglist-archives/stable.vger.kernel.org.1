Return-Path: <stable+bounces-113226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD93A2908A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83431635F4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0808634E;
	Wed,  5 Feb 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FGahFT6q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891F151988;
	Wed,  5 Feb 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766245; cv=none; b=j74GhA9n0XDMYs0bAwgu/Kkoe+zpNuoxlJxrUr2kpkMYBcdmNpXhYESIN/QVPHrcqYIuxIZ5Vu3XHaiiVJS6cvDNxtayNIp9hYp7aqMUH4uN9jKLn4bX6GH1FsJBO7cLx9UqynrJ2dY9tSkbfmxxYfcwZQJ5m73BtcX75aM00Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766245; c=relaxed/simple;
	bh=VVn75q8Wr2My5PhFazpIsHRPa1Tr30usfvmAp2nIoBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3lVG68YORIx5p4C5iMSTUXbo0V/IMJXgIUgqcFEaHqrMmBf4OOsp295XtgXQr4VZwVpGZ+Of0hUdCGAvXTbT38AfI2mgYJ6pPt6ADipFZ4kWoz9AYuLF5Vfaod0JaxdnWBE9/LyZj7J7SzrgwxAfwC1wOFjwqRk8ZK+Jd3x+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FGahFT6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F871C4CED1;
	Wed,  5 Feb 2025 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766244;
	bh=VVn75q8Wr2My5PhFazpIsHRPa1Tr30usfvmAp2nIoBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGahFT6qCF6Wc11a9ejpE5wCoMv7nBYt8lgbZiIiKQjCY6bP3RtzxFXa8lShNe7YX
	 rTUfiHvqJEJQZrxTeFygkD160TmabzcItISBn7CKwdzhyPcCp2nEXhkHgT1eqrsbkY
	 /kw7BeAHL/jnFU9dqTnBxlFzPZ9X4UxmZD+zdhfI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 345/393] net: xdp: Disallow attaching device-bound programs in generic mode
Date: Wed,  5 Feb 2025 14:44:24 +0100
Message-ID: <20250205134433.509516020@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 3595599fa8360bb3c7afa7ee50c810b4a64106ea ]

Device-bound programs are used to support RX metadata kfuncs. These
kfuncs are driver-specific and rely on the driver context to read the
metadata. This means they can't work in generic XDP mode. However, there
is no check to disallow such programs from being attached in generic
mode, in which case the metadata kfuncs will be called in an invalid
context, leading to crashes.

Fix this by adding a check to disallow attaching device-bound programs
in generic mode.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Closes: https://lore.kernel.org/r/dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de
Tested-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250127131344.238147-1-toke@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69da7b009f8b9..479a3892f98c3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9346,6 +9346,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "Program bound to different device");
 			return -EINVAL;
 		}
+		if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
+			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
+			return -EINVAL;
+		}
 		if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
 			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
 			return -EINVAL;
-- 
2.39.5




