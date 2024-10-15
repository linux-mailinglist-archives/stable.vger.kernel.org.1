Return-Path: <stable+bounces-85717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A499E895
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70595282D1E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CCA1E7658;
	Tue, 15 Oct 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p/4tLMdX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F01C57B1;
	Tue, 15 Oct 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994056; cv=none; b=DOpVBtfpNKVNHaTIaCP/g3mpOV/vHCDfl/p5NuDKv3Ai4jojjc+UUHtz/PbHAiTRq3wp1vj3LTRUvmsB+J5nmr1MzFFTg1PkA3GbDClvGHO68E4sYyaOhBTdd0q7Zcl8Cw9jZoEVOkL/jAXBlQ2lqlCs3kl5QMRWUh4N6mYo+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994056; c=relaxed/simple;
	bh=2EkQptEIQi+E591E/PGNc+p/G0Svw0rAjpHevq4S4i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZqwM1UCu2SdgL37JbWWERXYCZZ9KoVGQjGsxjwuqrYtXRYxna2TvcKZIv7IwyKJ/H2ksojwoo9FMAO8lJ0o0jn20jLKnoHaVYrTN0yegBN1Bn5JoOSrSwexDkDtacTNnL0iwZ29QbpV31yembnaUziEGfVz3IOuY00fdX+k/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p/4tLMdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2344CC4CECF;
	Tue, 15 Oct 2024 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994056;
	bh=2EkQptEIQi+E591E/PGNc+p/G0Svw0rAjpHevq4S4i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/4tLMdX9SqQ2UQQ+wGF/TGTWSsCl97YN688KG7nBviGSskvEIoCnrkbzXgBJPKqH
	 Lkee5wRSpwvSk9QNZkqA02mb7QJX7dBcihe8svCDuVx1LMl6rfhc8xKMxOmxxAw7Y0
	 iihHd8Ta4IaD/r3e0YjhSq5c9dL2U+HZ1rlz+hqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Torsten Hilbrich <torsten.hilbrich@secunet.com>,
	Mathias Krause <minipli@grsecurity.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 595/691] Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal
Date: Tue, 15 Oct 2024 13:29:03 +0200
Message-ID: <20241015112503.960431917@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Krause <minipli@grsecurity.net>

commit fbf8d71742557abaf558d8efb96742d442720cc2 upstream.

Calling irq_domain_remove() will lead to freeing the IRQ domain
prematurely. The domain is still referenced and will be attempted to get
used via rmi_free_function_list() -> rmi_unregister_function() ->
irq_dispose_mapping() -> irq_get_irq_data()'s ->domain pointer.

With PaX's MEMORY_SANITIZE this will lead to an access fault when
attempting to dereference embedded pointers, as in Torsten's report that
was faulting on the 'domain->ops->unmap' test.

Fix this by releasing the IRQ domain only after all related IRQs have
been deactivated.

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Link: https://lore.kernel.org/r/20240222142654.856566-1-minipli@grsecurity.net
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index aa32371f04af6..ef9ea295f9e03 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -978,12 +978,12 @@ static int rmi_driver_remove(struct device *dev)
 
 	rmi_disable_irq(rmi_dev, false);
 
-	irq_domain_remove(data->irqdomain);
-	data->irqdomain = NULL;
-
 	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
+	irq_domain_remove(data->irqdomain);
+	data->irqdomain = NULL;
+
 	return 0;
 }
 
-- 
2.43.0




