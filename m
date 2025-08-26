Return-Path: <stable+bounces-175173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18482B366E5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AA71899BF4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B448B34F468;
	Tue, 26 Aug 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="trVipTv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CB34DCF6;
	Tue, 26 Aug 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216334; cv=none; b=gx7c0AMT3vl9KUuVSacxtg2K5PsyHFCrZvBxLv/rmtx8eUzWVaztwCBFiKJy1yAiEbRh4cl9lZOocIiYi7bPDPp3IemIvoQxUlYW/oiQRNiUB06Am+ezvPa+V65XKNUfqaRi76QaycBr0d20M+UIT8SQFyiXxoDCxcyLnTr4rnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216334; c=relaxed/simple;
	bh=HVa81Vjk7QxlNRUW3A1FvmRJAaLFfG9ZxbEGJw3swao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJpcG/aq4NA/fqkWg3QA9ycBXE7P51/AJdZjBRS1SfyIkbYgD9WdTwwwGpyBbBnML9axmpijmz4sosbjtn3x6lPS6XRoi9eVHovOZaEihssAUsQgQ6Bj78VU4EGwqn8MfAS6kr94qM2iBm+vQCi0XpMXQJ3wM7ec/pxiyjJ5o5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=trVipTv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A39C4CEF1;
	Tue, 26 Aug 2025 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216334;
	bh=HVa81Vjk7QxlNRUW3A1FvmRJAaLFfG9ZxbEGJw3swao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trVipTv0jV87dKl/Q3e2B/0OdrCX6k1krPPtgUZkvyXJWknWh7ur1qVFOYP2TN024
	 m1II7PEp0Y2Hsw3UVHnwTcydW9iiELWkECcHX3nLXqaU05qLZ+J73e9CAN/Bb9tc7x
	 +Nrp7tyUy3pSSk8y7XCx8O7HSVHpuvCJsnKwwL+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 372/644] net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
Date: Tue, 26 Aug 2025 13:07:43 +0200
Message-ID: <20250826110955.637235314@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Álvaro Fernández Rojas <noltari@gmail.com>

[ Upstream commit c00df1018791185ea398f78af415a2a0aaa0c79c ]

CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
B53_PVLAN_PORT_MASK register.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Link: https://patch.msgid.link/20250614080000.1884236-14-noltari@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3bd0d1632b65..091ca9ca49aa 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -507,6 +507,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
 	unsigned int i;
 	u16 pvlan;
 
+	/* BCM5325 CPU port is at 8 */
+	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
+		cpu_port = B53_CPU_PORT;
+
 	/* Enable the IMP port to be in the same VLAN as the other ports
 	 * on a per-port basis such that we only have Port i and IMP in
 	 * the same VLAN.
-- 
2.39.5




