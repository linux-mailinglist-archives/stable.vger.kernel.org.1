Return-Path: <stable+bounces-131172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64809A80872
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063004E1CCF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0C270ED2;
	Tue,  8 Apr 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QDukt24i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D02270EDB;
	Tue,  8 Apr 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115683; cv=none; b=IXpJpemfczAVVwJjatV5w12WIl/sa1G9BJfbS/kHPSOFDwDELS7huUvKNzzfe5qwgnQ0DkgdXXgJsAEqWu/vDEGrbAVfwlBWSsFcmGZrUPZDuxEcp458c6+IHIoWfzP/wAz/I4321aGKwl3g1zQQwalRj+/trb+yO4IdxQ2YUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115683; c=relaxed/simple;
	bh=Nw9hoWvnYBfY8Xk9C8D7GssBsWcLYFBM0etfVLdMfU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kakkRNtDbjtTvHP7/IGri4kUe6T1OjFC7BhEQcV0x/z+Vp2+cR7lWP5b4RxTkvcEceC0LMpxvhMBJoHpU2Ff9kw4+iUH0ucO/J25WXsPeeHt7ZKp3J5Qtngla4wBKom2tpotApIpFpYI5pGd00v+t8dP82BLKZppk7x8Gpd5PK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QDukt24i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C680EC4CEEA;
	Tue,  8 Apr 2025 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115683;
	bh=Nw9hoWvnYBfY8Xk9C8D7GssBsWcLYFBM0etfVLdMfU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDukt24ieFQD/pPqJNIiEJ6462unQHLysZp/kPjuR5YmrIpDBv/S4GI0rbGYl1E0f
	 7fAnB6AgZtOBl2jM5i4kJLQYNjFSZ+jM8oAmQvpYCfqghjG5We4KRNLP9Tms9iZVLK
	 vhkFFrrJlLWeX93CF1DfatNbjLrxSvINSTiqqlrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 064/204] pinctrl: renesas: rzg2l: Fix missing of_node_put() call
Date: Tue,  8 Apr 2025 12:49:54 +0200
Message-ID: <20250408104822.236647447@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit a5779e625e2b377f16a6675c432aaf299ce5028c ]

of_parse_phandle_with_fixed_args() requires its caller to
call into of_node_put() on the node pointer from the output
structure, but such a call is currently missing.

Call into of_node_put() to rectify that.

Fixes: c4c4637eb57f ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250305163753.34913-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 159812fe1c97c..1304ab0bcac1e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1365,6 +1365,8 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 		return ret;
 	}
 
+	of_node_put(of_args.np);
+
 	if (of_args.args[0] != 0 || of_args.args[1] != 0 ||
 	    of_args.args[2] != pctrl->data->n_port_pins) {
 		dev_err(pctrl->dev, "gpio-ranges does not match selected SOC\n");
-- 
2.39.5




