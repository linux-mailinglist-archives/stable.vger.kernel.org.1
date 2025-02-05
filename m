Return-Path: <stable+bounces-113630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6371FA29334
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8963AFC2A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1457C189F5C;
	Wed,  5 Feb 2025 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IDswLxLI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C486CDF59;
	Wed,  5 Feb 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767623; cv=none; b=qblVtgB0QUeb1N1TMEnVMMHv4wqW1VtC97f/lglCINNqCYhWIWdCrPbj2sezCCf7bIBq7g/eHf+bw5sT09w9SzVDn4wY9N1MLzBXnhkKAxnOw1aa1H1Pl8KPwS1kL/3Gyb6PmMZvKVTqsyjrdq6V0uqujwf4BogtKRItAO6a7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767623; c=relaxed/simple;
	bh=t8uFL6n98acZ7YtiPsn/xehZQY7A2HB5rXY9Z/TfCdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIa3Zs/0YPlsibJ8Bb1uUi450pbMOCtH8HTPBTm1ttzxNBmjztjh1na35N7V4+Eor8X7yIOglR9hlWcFsS6IuSaQ/1Ox9TUBFqwhLBnCPg+B63az/TXKfKrV3pya9hvOFchkjGY9ZmQh4TNyJj9LPOcLpiEDS3MUKnUb9jfPaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IDswLxLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323D5C4CED1;
	Wed,  5 Feb 2025 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767623;
	bh=t8uFL6n98acZ7YtiPsn/xehZQY7A2HB5rXY9Z/TfCdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDswLxLI9zP6wG6f+LjlMVoxUjhzvDOdYe8aZVmAlO5w19YUOYoOy5h6r88DtvFjS
	 betgXQ4m4OekcfFG3l3A/nyZlGwptXlZ6GzAJfseNkCCEX0MOQ5na57DIc17PWNWXF
	 5U0BsPWtzF8iL9bAyi68G5pk8l39N+YqEDjXnXUI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 430/623] of: property: Avoiding using uninitialized variable @imaplen in parse_interrupt_map()
Date: Wed,  5 Feb 2025 14:42:52 +0100
Message-ID: <20250205134512.672930625@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit f73780e772c06901e99b2ad114b7f0f3fbe73ad4 ]

parse_interrupt_map() will use uninitialized variable @imaplen if fails
to get property 'interrupt-map'.

Fix by using the variable after successfully getting the property.

Fixes: e7985f43609c ("of: property: Fix fw_devlink handling of interrupt-map")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20250109-of_core_fix-v4-6-db8a72415b8c@quicinc.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index cfc8aea002e43..b0633f3589de8 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1390,9 +1390,9 @@ static struct device_node *parse_interrupt_map(struct device_node *np,
 	addrcells = of_bus_n_addr_cells(np);
 
 	imap = of_get_property(np, "interrupt-map", &imaplen);
-	imaplen /= sizeof(*imap);
 	if (!imap)
 		return NULL;
+	imaplen /= sizeof(*imap);
 
 	imap_end = imap + imaplen;
 
-- 
2.39.5




