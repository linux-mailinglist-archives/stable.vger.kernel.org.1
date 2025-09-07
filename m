Return-Path: <stable+bounces-178138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84922B47D67
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF21629C1
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809527FB21;
	Sun,  7 Sep 2025 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1p85FYzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E81CDFAC;
	Sun,  7 Sep 2025 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275886; cv=none; b=rkg39LQI+Zi57lAGo6rBr6vhDLIGIaZCfqJL7on4adUQ1Ne78I3gEoVp/kyBP+Ffz8NmxFSewXBES2LdwSKjX7aoIotWaWMncFNRetr8ikQEmei0qEYCFZBRYxBu8dF+Y7t5VdAu+FUeYsVFzGuzV8Bywaqfxc1RIWp0DvNtVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275886; c=relaxed/simple;
	bh=pWpRPlmJUDpGPAtNxBP/UI3gsyyMRe4dnAS0OVB9gm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNorIRwJUrk9sJe/rxkIovYByQcbbXqq/MbiSrTjX+lpts8m21EFlrxZfTu62N5xlAal5Ch9w9XhTfcHMgoJFmE9Pqc3HtqNfaLfN77eCXktcQVuc5ewMTmXcNF0yNZjmMcdJrKSULx0jfBhz6qtVlZR7PG4XxqhhZUB5T6T3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1p85FYzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51CCC4CEF0;
	Sun,  7 Sep 2025 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275886;
	bh=pWpRPlmJUDpGPAtNxBP/UI3gsyyMRe4dnAS0OVB9gm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1p85FYzQ5wRM3oN5s5y6mcUyUZ+C7Sg2W4scnU0uDwDCyIFI6Zm36ntFHm4DvaDQb
	 DUZMx9bPrhcOMSchnSklouddVlevXrgCuPLlXP9kzMlk8ek18jKYImYISwxQI8ulo3
	 lJ+2pMr9P+k8L/1wEdEHeIYRjWbwENpPl98VA8AM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 40/45] pcmcia: Add error handling for add_interval() in do_validate_mem()
Date: Sun,  7 Sep 2025 21:58:26 +0200
Message-ID: <20250907195602.167704267@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195600.953058118@linuxfoundation.org>
References: <20250907195600.953058118@linuxfoundation.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 4a81f78caa53e0633cf311ca1526377d9bff7479 ]

In the do_validate_mem(), the call to add_interval() does not
handle errors. If kmalloc() fails in add_interval(), it could
result in a null pointer being inserted into the linked list,
leading to illegal memory access when sub_interval() is called
next.

This patch adds an error handling for the add_interval(). If
add_interval() returns an error, the function will return early
with the error code.

Fixes: 7b4884ca8853 ("pcmcia: validate late-added resources")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pcmcia/rsrc_nonstatic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 6b311d6f8bf02..12bcbeca4a448 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -375,7 +375,9 @@ static int do_validate_mem(struct pcmcia_socket *s,
 
 	if (validate && !s->fake_cis) {
 		/* move it to the validated data set */
-		add_interval(&s_data->mem_db_valid, base, size);
+		ret = add_interval(&s_data->mem_db_valid, base, size);
+		if (ret)
+			return ret;
 		sub_interval(&s_data->mem_db, base, size);
 	}
 
-- 
2.51.0




