Return-Path: <stable+bounces-175485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91647B367EF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D103B63AD4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488B6352FD6;
	Tue, 26 Aug 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvKTZn9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2A352071;
	Tue, 26 Aug 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217169; cv=none; b=jvoSEc8XTAZPR0EEOl0GTJxt4eFOS4gsGZE8Tu3eKhpwBNmTtRJg8d84ARnT9C9snNhoFkvuaAks33exD0bqtXGrWLL+UAYiFEH5BaJvOZzX5vUkk3cimS7jRx8fYDYV/2hlS6dRi4iqeIozbWUrP0zzTHyNOtunLKDRRFZWV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217169; c=relaxed/simple;
	bh=JkgomygcM73VncNcYDUqPfP+sLvO9lGYM5Wb+oCkQiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcggOY+xstraqQv/xodmeuaewF+Qy7TUoSLTFjwBDjf31JOi0dUO05EiOgYPLu/mwTkbOaVjcQVup5xV2KDP+FFH2vVjALo+h7ldRFZ1Mwf0MLY79iv8l0VUTbCd7cEwXd1vSeJKWmeD2UnDPYjedN0NSbmFqtWotKdw1TeXW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvKTZn9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816CCC4CEF1;
	Tue, 26 Aug 2025 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217168;
	bh=JkgomygcM73VncNcYDUqPfP+sLvO9lGYM5Wb+oCkQiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvKTZn9HXNFL5bsMyNzVD6zLl8UQInDSYjtczO7CFW/9pSnzUhR+m8SRJ9lBtvqMe
	 +18v2cyJPLWSt/KFvjbg7QNApfFIGYZUgDc0MA3cZBr/uzWLDcqvXRKfZ9aRUq1Z50
	 YCeljMIwo5BFaO+1Bk1GEHMfTq9nWIdbtTEEYWG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 042/523] Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU
Date: Tue, 26 Aug 2025 13:04:12 +0200
Message-ID: <20250826110925.638911721@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit d24e4a7fedae121d33fb32ad785b87046527eedb ]

Configuration request only configure the incoming direction of the peer
initiating the request, so using the MTU is the other direction shall
not be used, that said the spec allows the peer responding to adjust:

Bluetooth Core 6.1, Vol 3, Part A, Section 4.5

 'Each configuration parameter value (if any is present) in an
 L2CAP_CONFIGURATION_RSP packet reflects an ‘adjustment’ to a
 configuration parameter value that has been sent (or, in case of
 default values, implied) in the corresponding
 L2CAP_CONFIGURATION_REQ packet.'

That said adjusting the MTU in the response shall be limited to ERTM
channels only as for older modes the remote stack may not be able to
detect the adjustment causing it to silently drop packets.

Link: https://github.com/bluez/bluez/issues/1422
Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/149
Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4793
Fixes: 042bb9603c44 ("Bluetooth: L2CAP: Fix L2CAP MTU negotiation")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8c8631e609f6b..b6345996fc022 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3682,12 +3682,28 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
-		/* If MTU is not provided in configure request, use the most recently
-		 * explicitly or implicitly accepted value for the other direction,
-		 * or the default value.
+		/* If MTU is not provided in configure request, try adjusting it
+		 * to the current output MTU if it has been set
+		 *
+		 * Bluetooth Core 6.1, Vol 3, Part A, Section 4.5
+		 *
+		 * Each configuration parameter value (if any is present) in an
+		 * L2CAP_CONFIGURATION_RSP packet reflects an ‘adjustment’ to a
+		 * configuration parameter value that has been sent (or, in case
+		 * of default values, implied) in the corresponding
+		 * L2CAP_CONFIGURATION_REQ packet.
 		 */
-		if (mtu == 0)
-			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+		if (!mtu) {
+			/* Only adjust for ERTM channels as for older modes the
+			 * remote stack may not be able to detect that the
+			 * adjustment causing it to silently drop packets.
+			 */
+			if (chan->mode == L2CAP_MODE_ERTM &&
+			    chan->omtu && chan->omtu != L2CAP_DEFAULT_MTU)
+				mtu = chan->omtu;
+			else
+				mtu = L2CAP_DEFAULT_MTU;
+		}
 
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
-- 
2.39.5




