Return-Path: <stable+bounces-184395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C4BBD3F87
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B30C188C81B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D16730CDAF;
	Mon, 13 Oct 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YfYRbIEy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B40277CB8;
	Mon, 13 Oct 2025 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367313; cv=none; b=akvgP09GtVlHxLBgvX2pj4aK6zeX2+a2w7lY06WQtiwIBDbxv4nmP3rRNU3yeGerFNP8T+j+66d2yddNP0cniamiRfSlsjjMtIh7Gv5OUnWowrzjoOrO56TIxCWSePjc9aAiWDrA8zRvtJwdl0IxCsUNnAvZzOAGH3oUh39jR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367313; c=relaxed/simple;
	bh=IYPRq0vzMyHLOpZTRAYNEkqnR3Cr7OM9TiEimWDZHC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqqQEmvPZOnvZ1bYgUpmXcCitcmZFGrqp0w+9z4KHM/uOyV5m1KMmo7y+snbcob+YWFzrz3vbmOG30m5Ge1vYPgcu2JXuXoKrxvxLGlZrYEdBr+hser1iNHmCFroy+7VxJt2qAVK3FkhwjWMeAltA8w3jXB7ornv8OUtBmGVBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YfYRbIEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371A6C4CEE7;
	Mon, 13 Oct 2025 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367312;
	bh=IYPRq0vzMyHLOpZTRAYNEkqnR3Cr7OM9TiEimWDZHC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfYRbIEyfLZJ7YHDobG1YkYXsPJ/zu4V2ILt/vPVzxtmsPtZQ7BBBDwG9M6bema/r
	 2Z0CDGMuiIO5I1KclvSWEcF2He2y/TtqwiFvWdLX7pAZXK4EAIdPuFQ71Vj592rG+I
	 Jt/BFq8xowbnfnNIPKOHVRE1O5bdStdzbSb1jqA8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 158/196] Bluetooth: ISO: Fix possible UAF on iso_conn_free
Date: Mon, 13 Oct 2025 16:45:31 +0200
Message-ID: <20251013144320.414963514@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 9950f095d6c875dbe0c9ebfcf972ec88fdf26fc8 ]

This attempt to fix similar issue to sco_conn_free where if the
conn->sk is not set to NULL may lead to UAF on iso_conn_free.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 437cbeaa96193..5f6e4c79e190b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -581,6 +581,13 @@ static void iso_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
+	if (iso_pi(sk)->conn) {
+		iso_conn_lock(iso_pi(sk)->conn);
+		iso_pi(sk)->conn->sk = NULL;
+		iso_conn_unlock(iso_pi(sk)->conn);
+	}
+
 	/* Kill poor orphan */
 	bt_sock_unlink(&iso_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
-- 
2.51.0




