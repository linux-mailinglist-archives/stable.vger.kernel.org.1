Return-Path: <stable+bounces-129076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBC4A7FDF2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6C3444814
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C252686AA;
	Tue,  8 Apr 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zw7wJhxF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFB267B7F;
	Tue,  8 Apr 2025 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110049; cv=none; b=KMN1ePLFq7KRRQxO63Kwx34lL5U69HaVQr39HVd7ryhAL64/wP5EFTDMKYwUzBu+7Sf/kflGn+BAJAG+t2F4k7fiqDirK/mxdTi6Up/6ectBnekbXaBVmpM44A4YgiplUyJuvcYmBLx302F5oDk6SwaIEriVIbuZ39aQMv7RSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110049; c=relaxed/simple;
	bh=YeK6/pToITZVGW56GnUBDitfZBF43+dmlBnAHnIediU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msvWWcGbjIJmGJHy5H65hYbHhw9a73fDSgW3e/BsLgCpPqwDRErygW3M3rDyJdUQXoQOR6WKxtqwOx8LKWBaksNXF3aJONhUqbFZxjYoUbe+zuLWba8pGGZ6GRADEyA6iBomQ55AmOaVe9lpqdABwm9HiFOzmpOAoHVo4Hs0JMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zw7wJhxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA3BC4CEEA;
	Tue,  8 Apr 2025 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110049;
	bh=YeK6/pToITZVGW56GnUBDitfZBF43+dmlBnAHnIediU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zw7wJhxF0x86TCtsTJSFJXux+f2RAWWpGex0HQJEggiWGjDmP6gCen+zqFT18kVAs
	 hR4qcHPznJPveknAt4kHcrAFtYRb/RjN0Sacu6BlVmCxsA4tacXKWe+zaVw3Y3rFG5
	 FZQcpyoecOK5VVxcarZ+Jk6pDpz/tc+16mq6J+9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 149/227] pinctrl: renesas: rza2: Fix missing of_node_put() call
Date: Tue,  8 Apr 2025 12:48:47 +0200
Message-ID: <20250408104824.785233151@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit abcdeb4e299a11ecb5a3ea0cce00e68e8f540375 ]

of_parse_phandle_with_fixed_args() requires its caller to
call into of_node_put() on the node pointer from the output
structure, but such a call is currently missing.

Call into of_node_put() to rectify that.

Fixes: b59d0e782706 ("pinctrl: Add RZ/A2 pin and gpio controller")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250305163753.34913-5-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rza2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index ddd8ee6b604ef..1fd3191d9f8d9 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -253,6 +253,8 @@ static int rza2_gpio_register(struct rza2_pinctrl_priv *priv)
 		return ret;
 	}
 
+	of_node_put(of_args.np);
+
 	if ((of_args.args[0] != 0) ||
 	    (of_args.args[1] != 0) ||
 	    (of_args.args[2] != priv->npins)) {
-- 
2.39.5




