Return-Path: <stable+bounces-163875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6B5B0DC28
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D18D3B1A79
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3A2EA490;
	Tue, 22 Jul 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GH0lVv8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB82EA47D;
	Tue, 22 Jul 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192499; cv=none; b=Wm43iuyK5YLFD1WhF8FqW3HSECeV2wqlOQdu/D/9e4gDhS0M/jy6WgM0I/FxB46M/CuRN9T8zrJcLHvvL6AVKY6x27MKvA1HdhTaf2WliWtVZEDz0A3vwg4cxRXYFlBQYj9Ull+Wj9S5PNwH/PJjidAFO6eIdKxEWDXxlgNxU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192499; c=relaxed/simple;
	bh=vFeIVwl4UmSmvQMxI4frWj67iZyd9a+7x2lWOqqcoEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxxZpGnQT6ShLvDszeuhlekBDfCmo6L+sk4PxxMBoTaZy8fY5ipq3L/yVUzEaW7Q38S+hyzzs/TACMVE9v5UKd4mRgkOvqNynPu5pQrv1mIlM1kCriIXBVbCQOE0GRI9jNGQ5b/5MPIKTniCIYhMW3xAPAZ6fG5pDLlJ/gaqUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GH0lVv8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E56BC4CEF9;
	Tue, 22 Jul 2025 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192499;
	bh=vFeIVwl4UmSmvQMxI4frWj67iZyd9a+7x2lWOqqcoEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GH0lVv8EdmTNIN8F/qETtPybgNXcovWDkCX9RV5y1YLKkh0yAu0njoyC6gWaXbChB
	 ZjSzCgwGvGR3Rp/DLkBrsguV34zUmWJpcv27owZGBAeZSr9EatgfzoUN270zV6Itke
	 IfxFQD9Y28evd6Xgv5L+zg4zlL7MKxwddP15B83Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 084/111] Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU
Date: Tue, 22 Jul 2025 15:44:59 +0200
Message-ID: <20250722134336.530491726@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
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
index f9995a405e35c..dabc07700197c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3485,12 +3485,28 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
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




