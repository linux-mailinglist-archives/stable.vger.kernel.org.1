Return-Path: <stable+bounces-105984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C869FB295
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1DC188159C
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8FF1A8F99;
	Mon, 23 Dec 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TNDGeNyE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7517A597;
	Mon, 23 Dec 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970803; cv=none; b=dCuhu9baxfjgTXMdwncQ3K0ScJDzJhXqwcuJFn2bhjiGCzHeNvHx1QI42Q1OZeqoKZ/EuVVkmVKOVGnrTHbOTwByQPELGR14uALD7lXU0yyOXfw6GuxwqKzQC+9kF7mtw7TdP10mJezOh03g6SK6zB2iGEdz2SHwv+yk3yH+k1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970803; c=relaxed/simple;
	bh=jiJDkTECnvzFzqDSY3yAWFDO5hRd6r9ujAuB3vgO2S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzF1imiqnDmys6lKBLXPfASN1om7pxYvGSoYRvDVEPg4QGnZqa7lY87uoJXTg6lGgNHb0Y6HsSH6ZeozkhRLph9Iy+NLPXaAWmOF1BHQWH/8fWZC4k15n9MyqonKtJc4giNL7QL4OClmwiOxmSm8J1TyeAJaA5y/rQfJwUawpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TNDGeNyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4E1C4CED3;
	Mon, 23 Dec 2024 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970803;
	bh=jiJDkTECnvzFzqDSY3yAWFDO5hRd6r9ujAuB3vgO2S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNDGeNyEgmrXNYrcPBi7ySZw6dDeBy8xPKDlcBver37l5UD3m+Xkx5k1OZtnJhDyl
	 b/+i6YTR1kQMRis+IQgSos4W7SxlNlOKnZUfBP1Bmh3vl2LC40GRliSPDAFIVUuGOi
	 Alu/6J0YbT241XwHj/TZymM6tfHw/DcpO+71fToo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.1 74/83] of: Fix error path in of_parse_phandle_with_args_map()
Date: Mon, 23 Dec 2024 16:59:53 +0100
Message-ID: <20241223155356.501268189@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
References: <20241223155353.641267612@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit d7dfa7fde63dde4d2ec0083133efe2c6686c03ff upstream.

The current code uses some 'goto put;' to cancel the parsing operation
and can lead to a return code value of 0 even on error cases.

Indeed, some goto calls are done from a loop without setting the ret
value explicitly before the goto call and so the ret value can be set to
0 due to operation done in previous loop iteration. For instance match
can be set to 0 in the previous loop iteration (leading to a new
iteration) but ret can also be set to 0 it the of_property_read_u32()
call succeed. In that case if no match are found or if an error is
detected the new iteration, the return value can be wrongly 0.

Avoid those cases setting the ret value explicitly before the goto
calls.

Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20241202165819.158681-1-herve.codina@bootlin.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/base.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1597,8 +1597,10 @@ int of_parse_phandle_with_args_map(const
 			map_len--;
 
 			/* Check if not found */
-			if (!new)
+			if (!new) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			if (!of_device_is_available(new))
 				match = 0;
@@ -1608,17 +1610,20 @@ int of_parse_phandle_with_args_map(const
 				goto put;
 
 			/* Check for malformed properties */
-			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
-				goto put;
-			if (map_len < new_size)
+			if (WARN_ON(new_size > MAX_PHANDLE_ARGS) ||
+			    map_len < new_size) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			/* Move forward by new node's #<list>-cells amount */
 			map += new_size;
 			map_len -= new_size;
 		}
-		if (!match)
+		if (!match) {
+			ret = -ENOENT;
 			goto put;
+		}
 
 		/* Get the <list>-map-pass-thru property (optional) */
 		pass = of_get_property(cur, pass_name, NULL);



