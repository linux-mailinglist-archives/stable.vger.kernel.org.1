Return-Path: <stable+bounces-178059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F5B47D13
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14F03BD516
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F227F754;
	Sun,  7 Sep 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lY1kNjXx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5301CDFAC;
	Sun,  7 Sep 2025 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275633; cv=none; b=ZNO3AUpJ17UtbvLhGafPxNd4MVX4sZbVDClGN61+pKRLg+AiYIO93kU8RotwZ/lyYK3gaUGWDnE3uOb7a36SKGfXV7L527jIWxFadThAJmldBfd9sB3I2GsRKTQzEn5c6W1k+Eqi73VeQ2BUmGjewAfK9aaPCKR3kIWaqLzODVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275633; c=relaxed/simple;
	bh=nrsITbBhBMk3kIp7VzH+W0Z112ohJfXRzggwOgCnKik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBU6pn+5k9z8zfOLt1zHYkOwjsSRYbTyjV+okMMPzemyMlWbyCSXi7GjyXI2UQn7/ByY8ersbuvBMug7O6MqZfy1SMpyB6MYc8/VTNRiWVAN8TWX3i+qUTjqQu+hHNolbYT36UL24HKoL5ZSg3E4T769X5kfsryyUgEivmMZj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lY1kNjXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70E9C4CEF0;
	Sun,  7 Sep 2025 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757275633;
	bh=nrsITbBhBMk3kIp7VzH+W0Z112ohJfXRzggwOgCnKik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lY1kNjXxUGuQ+TPVclLkWhoicXvvHjIh4pMIrcwTQsrgi8lM94ZnK5KCtRg62D2tz
	 trxHhtV3ig5NpuisG+wJAnew67IXsxLQRBTHsVEQY202FhzTXGkPOgE+l6suK0FiX9
	 pcrz9h3JCZ7v2HoxERG5IJYGQw9xoimflimg+/NA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 16/52] ipv4: Fix NULL vs error pointer check in inet_blackhole_dev_init()
Date: Sun,  7 Sep 2025 21:57:36 +0200
Message-ID: <20250907195602.462712760@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195601.957051083@linuxfoundation.org>
References: <20250907195601.957051083@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit a51160f8da850a65afbf165f5bbac7ffb388bf74 ]

The inetdev_init() function never returns NULL.  Check for error
pointers instead.

Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/aLaQWL9NguWmeM1i@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/devinet.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 2dc94109fc0ea..bf85978145197 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -332,14 +332,13 @@ static void inetdev_destroy(struct in_device *in_dev)
 
 static int __init inet_blackhole_dev_init(void)
 {
-	int err = 0;
+	struct in_device *in_dev;
 
 	rtnl_lock();
-	if (!inetdev_init(blackhole_netdev))
-		err = -ENOMEM;
+	in_dev = inetdev_init(blackhole_netdev);
 	rtnl_unlock();
 
-	return err;
+	return PTR_ERR_OR_ZERO(in_dev);
 }
 late_initcall(inet_blackhole_dev_init);
 
-- 
2.50.1




