Return-Path: <stable+bounces-66778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5A94F267
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDB3281448
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8B186295;
	Mon, 12 Aug 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="od4f+zK9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71011EA8D;
	Mon, 12 Aug 2024 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478752; cv=none; b=fziGJjLYiZolXyVzkt6Nx2yhiesx68jgBa8IxsvTr+4O20t17eHdmZn45MpWzi78CjKAML7sAokSEXV3Hh5SzbYfXV0g+7NIQACFxfFwqDE3NbWQBc+vwVvvU/GLbMVPTQR03SKkZx333j+mBygVc1m55yGomZNqBCYLzMnvQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478752; c=relaxed/simple;
	bh=ZUvohcobtlLU+sPVN2F/A80IIeXle2sThwfH5B7LKy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6Sbcan6UxwaepOUHhRazcFj9sIwE98P0j4dazUHDz1+3HqfuK0XZOAb6/nyqyC005Xi8oilEiWWqT5wwzYsePjzeE4Trp9CSiE409Tk8pppXL0jm0tgcME8alC8SVC1OsAUfneQYdgSS9Bg3/30DOCZAKVif+BM2MlRazh7kSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=od4f+zK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE74C32782;
	Mon, 12 Aug 2024 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723478752;
	bh=ZUvohcobtlLU+sPVN2F/A80IIeXle2sThwfH5B7LKy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=od4f+zK9K2oTytdBDjzbd7LCAuz59q7xYZJp2i46BMl+PnF/GpdwgzDYMJFcNnE0S
	 ARZOBbek7ulU8bu44xQooucvk63eWxYpbqFzakFBxEqn8RX8hvxppfnNNS3/TUVi5/
	 c95nrxDNjMwWcd61wYeveekao2WCrVH2gPnzDQAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Palmas <dnlplm@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/150] net: usb: qmi_wwan: fix memory leak for not ip packets
Date: Mon, 12 Aug 2024 18:01:29 +0200
Message-ID: <20240812160125.474195661@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit 7ab107544b777c3bd7feb9fe447367d8edd5b202 ]

Free the unused skb when not ip packets arrive.

Fixes: c6adf77953bc ("net: usb: qmi_wwan: add qmap mux protocol support")
Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 46e0e1f1c20e0..ee0ea3d0f50ee 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -200,6 +200,7 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			break;
 		default:
 			/* not ip - do not know what to do */
+			kfree_skb(skbn);
 			goto skip;
 		}
 
-- 
2.43.0




