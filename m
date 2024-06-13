Return-Path: <stable+bounces-50795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F7A906CBC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D546C28300B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713A1465A3;
	Thu, 13 Jun 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ta4iH1wa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A0145B27;
	Thu, 13 Jun 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279408; cv=none; b=F/yWWJ0s5HBjt3Xi77Gl0zay4PIl2sKTHQIHr0KTVCWxZbYo13waZxTQlE5lWi5mwGG8w7nBXQoYOe+jXeJ+xVrlaHBTNhudljiV0HvXwRViPjuUNdKU5oAKGRCw8Pur8QnaAqYihItRXHpgedjQhfHzMP81EHV248qVa50+bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279408; c=relaxed/simple;
	bh=Socy7SCSRZHgneyW5tizQOhggU7JJkyeuNkZzwNNfUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXl/yRBz7c+wuQzXQE9C/0U9pZz4xoJ+y5OWsA9ioe9sARJCCYEcgq96sgKRlF9o4jIgJxv4jyHZ+GGSuTaJtGkcuapHT209LuB80M8JHthfeRMPLokFOcsyPdYtn7KQIvyE3DhQyIUQBcw+dlcdO8UzjrYzYYDgblplEk7+9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ta4iH1wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECAFC2BBFC;
	Thu, 13 Jun 2024 11:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279407;
	bh=Socy7SCSRZHgneyW5tizQOhggU7JJkyeuNkZzwNNfUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ta4iH1waS75oy96R4Be67uoJwdO+EAfRJevyn7VrUzFzTwAIpywPPoPASp6Qsk6XR
	 molZZmgljZXgPJOUvq9Tt5gfSQ8kjuTbti7mSDZFkN3Ipn+V4ZX1paJFmlIu8bZRor
	 J+RRLn0iF701ik1/UhcTwadFhBIY1EK17GnSvD5A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.9 066/157] clk: bcm: rpi: Assign ->num before accessing ->hws
Date: Thu, 13 Jun 2024 13:33:11 +0200
Message-ID: <20240613113229.975660219@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 6dc445c1905096b2ed4db1a84570375b4e00cc0f upstream.

Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
__counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
with __counted_by, which informs the bounds sanitizer about the number
of elements in hws, so that it can warn when hws is accessed out of
bounds. As noted in that change, the __counted_by member must be
initialized with the number of elements before the first array access
happens, otherwise there will be a warning from each access prior to the
initialization because the number of elements is zero. This occurs in
raspberrypi_discover_clocks() due to ->num being assigned after ->hws
has been accessed:

  UBSAN: array-index-out-of-bounds in drivers/clk/bcm/clk-raspberrypi.c:374:4
  index 3 is out of range for type 'struct clk_hw *[] __counted_by(num)' (aka 'struct clk_hw *[]')

Move the ->num initialization to before the first access of ->hws, which
clears up the warning.

Cc: stable@vger.kernel.org
Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240425-cbl-bcm-assign-counted-by-val-before-access-v1-2-e2db3b82d5ef@kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/bcm/clk-raspberrypi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -371,8 +371,8 @@ static int raspberrypi_discover_clocks(s
 			if (IS_ERR(hw))
 				return PTR_ERR(hw);
 
-			data->hws[clks->id] = hw;
 			data->num = clks->id + 1;
+			data->hws[clks->id] = hw;
 		}
 
 		clks++;



