Return-Path: <stable+bounces-200633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D0CB2439
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2917B303459E
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 07:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E7302CCD;
	Wed, 10 Dec 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+Kg2tbO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A59C2FF16C;
	Wed, 10 Dec 2025 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352086; cv=none; b=qzBCIsVcqOkc96kz7Muj0qD4qxH4X+swVFWsDmLQiMdetjKfP4iB6nf9prPd9RdwAKKRiPJiN0C1YRN4V+6tes3gXacezYP3DLDuaE6yP/5zLdhbk9IItOD1m1AWXtIX4DB4or2B/S3FJHH+gEAfV4kGZo0Tj0Tlh0+Lw8ii3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352086; c=relaxed/simple;
	bh=mKv86J3aCkI386PkxxDgoDHpTjF3xccfCQ3shWdptdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i33BWVKkvfvByfLKdLf15McWLW61+51HAw6pRVzKTpcm6U9wEvRJ9d1UxJV+J3BSKEJFMAQjxv+BgHvV6U25he6AIcWGzRHsEhWWuLJOU9CU4qms2ZpZsg/e0VyEGgNA9JU8gyslho6yFThAMDXgLvcMpnZiqNOtfxpGL/31cbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+Kg2tbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8C7C4CEF1;
	Wed, 10 Dec 2025 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765352086;
	bh=mKv86J3aCkI386PkxxDgoDHpTjF3xccfCQ3shWdptdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+Kg2tbONFpVhjWDEDxMbTcFxJqW3vIIGNu9TqHZ4rVqpPL51aYG/BSa5LsshmLF6
	 ZHcFiOuN8EK31m3XK2cUfvO6J/6cQNrTvGXh7dwRFSzJ6bXvL768NlWz/jmtfYIazI
	 hUQznWzRPdVEVLn/KxML5KwZbN8WgED/h6vLwI+8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.17 15/60] dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
Date: Wed, 10 Dec 2025 16:29:45 +0900
Message-ID: <20251210072948.216940888@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
References: <20251210072947.850479903@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a6cdfd69ad38997108b862f9aafc547891506701 upstream.

Drop "uart-has-rtscts: false" from binding as the IP supports hardware
flow control on all SoCs.

Cc: stable@kernel.org
Fixes: 25422e8f46c1 ("dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114101350.106699-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/renesas,rsci.yaml |    2 --
 1 file changed, 2 deletions(-)

--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -54,8 +54,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  uart-has-rtscts: false
-
 required:
   - compatible
   - reg



