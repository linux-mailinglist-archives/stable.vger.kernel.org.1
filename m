Return-Path: <stable+bounces-149581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B184DACB3BE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389E21944307
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6D722A7E2;
	Mon,  2 Jun 2025 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bcW8aE+/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49E222587;
	Mon,  2 Jun 2025 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874391; cv=none; b=sTe3C7nRTqnn3KCxZtt7DIlkvlunaF4e0i7shP4AhQUOc3eXNeL6gz3YXShEtQK4hIigH/hQ0/XFZiAewAaSiYAWMdlAcHlp0BdsehFhuLOxvUo3EYY9NhK12QiZ2Zq3t6iYjw7+FnY7ENg/oat5fl51pBogqMBdtmfrFH7oOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874391; c=relaxed/simple;
	bh=RwuYqXo9v28kRb6qLbUpR9HBdeAuawuimMQ92sAxwew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzm/+W029oFcO+vi0IEpJ4LLhwwQkUc69gTp93otGSJgGATn/868dXfmsPtXbZ9jUh9SK1pKtwc8XWfLBWVfILQY4e23rn+KWTOnezSVVsMDpg43D0y9XleMIy875rPOMTLdQfxPAx1CwPsK5HMdPQKXDKRDaSVZiZPveEBRW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bcW8aE+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3ABC4CEEB;
	Mon,  2 Jun 2025 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874391;
	bh=RwuYqXo9v28kRb6qLbUpR9HBdeAuawuimMQ92sAxwew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcW8aE+/EiOPvi/X73qUdUFJ3ikGxpS09eyCobLd7LzjukOv6WQQyjjY+MUoqn5VP
	 zgkjCabT183D+kbjUd29cWkunpRHRTJ0LE0LjXQZyiaUS4Q/I2yzsHkenvXjbpeOWB
	 1gNvkrkt3RS9cks5SPmPCux/eIibkAwNKCZG/ng4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niravkumar L Rabara <niravkumar.l.rabara@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	stable@kernel.org
Subject: [PATCH 5.4 001/204] EDAC/altera: Test the correct error reg offset
Date: Mon,  2 Jun 2025 15:45:34 +0200
Message-ID: <20250602134255.521463824@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>

commit 4fb7b8fceb0beebbe00712c3daf49ade0386076a upstream.

Test correct structure member, ecc_cecnt_offset, before using it.

  [ bp: Massage commit message. ]

Fixes: 73bcc942f427 ("EDAC, altera: Add Arria10 EDAC support")
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Cc: stable@kernel.org
Link: https://lore.kernel.org/20250425142640.33125-2-matthew.gerlach@altera.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/altera_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -96,7 +96,7 @@ static irqreturn_t altr_sdram_mc_err_han
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,



