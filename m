Return-Path: <stable+bounces-55107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F5915872
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 23:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0A91F2575E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9651A070C;
	Mon, 24 Jun 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5mMH+P+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09259FBEF;
	Mon, 24 Jun 2024 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719263421; cv=none; b=FsGCrIWE25zr3wwePdZ/MVf41D6/4wJ/jU/qVbPuVNucIx99XezVlALN6Xq8JnY+S4LLzM6PyjhTmAcSrnpJufFTBaSwTXRgq3ysR+pbql3RgBjNbnE+Zd3BjcR4mJRUpyPTkg99z+sYyE0oi44B/gxdUdxLlCT7A9b8pYlcx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719263421; c=relaxed/simple;
	bh=zIXCk75aYHpcTxk2IWR/+FVXsSNkawGDCSBB195Y8Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YXN5qvOK4Aaw9Y7B9CvlNrKZjDLM4RJy80iFSvlKDbWUIG5m0z5lmtjxbkBXVp3yeBEyBPjzBVQwrijKURpMeOSq7k9K9JhWAwim5e8jzZ0eoNdRTNTL8z2P/rxDwZHZX6gmoUJRM4Gd9ii1wwHhSAlfNbtdourkcLurXJJHwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5mMH+P+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217990f8baso42606925e9.2;
        Mon, 24 Jun 2024 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719263418; x=1719868218; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7h4Mx2Vzzy1/ph7K1w6trMWSYerI+1F9zFKh72PTopU=;
        b=C5mMH+P+nDgR3umbV0Lm2065/kvjkfhC5vmpWMNmqgFDFrRSKJQehtViAXc+MBMHXW
         +CxdcNBTxrDuGng/nmbuVssT6h07EfCdteL3Afx92Dm1ExzxeIiafp+vJ4BdOrFRQTjb
         dGVeJpcOmm68L5bRipKS0SKSISHJLMCPy3Q4/lWL4UCstFQFjGM0jL3ekzkGAVT3Wjnv
         oeuoLoSnunVHhwUZikPglZeEWrCX0YwEVm6CluRo/OSUMewduzVYVmhGJuVKscRV4ETM
         HuZ6Pwr2uFFZTkW7QSphoVWm01M6NX9aGXLae578GRHEaZZVO42LReJPzZ9LwX1Q63eV
         OxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719263418; x=1719868218;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7h4Mx2Vzzy1/ph7K1w6trMWSYerI+1F9zFKh72PTopU=;
        b=ncqtz7UdN+zfboCK+OcxD5LiCDVKKk4NVruxq2ukUKrMpMSSPb5ZPaN1CiNsIu1CYX
         ojMRjF8D7ndBSCO8dFSVY47UShhYHBZF0EaZ/JlFVfVcik8sILajtC1yJX0EeE5UTJya
         qVA6qNFDYVc7MVrWDl+tyG1DnXU+QdPrZUyHdaWXf7wBEFDInfD7GS2zKnXGANdZzR1g
         fgzCD7XNsLeuPB2zfd7z/j10b11Y0T0xW4EAkm1govc3rx6lF9T7ZkgToiPvktnOtXKP
         GHjMYVyPb1+V9uIKZM/ERcjWDjv1Rn+pKCFLJgyddUsC/zYCmzGjIuVPqvzLaJmvvVWv
         1LZA==
X-Forwarded-Encrypted: i=1; AJvYcCX0aYSMIODetbd1ViZj8CxVTywui36qgTLp6/NZUtXmJjvq+2PBB36hFBi0tDpI0qt02w4tI4rbGtwK/av1kd1OLSoHbW2HIPJIyQtdmdd1T8TVoO7yiBSOQYOOmaWoM9cxkzhI
X-Gm-Message-State: AOJu0Yy5lYgcGMzmW+axRagfLpRMaWeo0b25imcQVtavv04Xh9AbsZ+U
	atty+5mLWCs55Ad6HEZbX6jVlsVuVNCd6tKyZdqKty5aG7CBGlRMXwFMSVcX
X-Google-Smtp-Source: AGHT+IFL2g9nbddRwxvFCZcjQygcMRWl9lESJW9Y7LWtGqJ2anOaUschGrkdt6Ny6ai/6teIVtnsCw==
X-Received: by 2002:adf:fd87:0:b0:360:81d2:b06b with SMTP id ffacd0b85a97d-366e79fdfbcmr3360529f8f.18.1719263418139;
        Mon, 24 Jun 2024 14:10:18 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638f86566sm11110573f8f.64.2024.06.24.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 14:10:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 24 Jun 2024 23:10:06 +0200
Subject: [PATCH] usb: core: add missing of_node_put() in
 usb_of_has_devices_or_graph
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-usb_core_of_memleak-v1-1-af6821c1a584@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK3geWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMT3dLipPjk/KLU+Py0+NzU3JzUxGxdc0tDM0MzI+MkM6NUJaDOgqL
 UtMwKsKnRsbW1AJ+KZjllAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Stephen Boyd <swboyd@chromium.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719263416; l=1531;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=zIXCk75aYHpcTxk2IWR/+FVXsSNkawGDCSBB195Y8Q0=;
 b=+ByHjcUALzgzweObJ0Ak9OHgaplq8/LAdvC9xDCh1inm6nL1TSPfW/zbMcSEfGTcAuQwNZ/oI
 PGEVDaWv2upBwgyNRcBV6e447rk2NwklbZh7a14JEzGBzRbv9rWhR0b
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The for_each_child_of_node() macro requires an explicit call to
of_node_put() on early exits to decrement the child refcount and avoid a
memory leak.
The child node is not required outsie the loop, and the resource must be
released before the function returns.

Add the missing of_node_put().

Cc: stable@vger.kernel.org
Fixes: 82e82130a78b ("usb: core: Set connect_type of ports based on DT node")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This bug was found while doing some code analysis, and I could not test
it with real hardware. Although the issue and it solution are
straightforward, any validation beyond compilation and static analysis
is always welcome.
---
 drivers/usb/core/of.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
index f1a499ee482c..763e4122ed5b 100644
--- a/drivers/usb/core/of.c
+++ b/drivers/usb/core/of.c
@@ -84,9 +84,12 @@ static bool usb_of_has_devices_or_graph(const struct usb_device *hub)
 	if (of_graph_is_present(np))
 		return true;
 
-	for_each_child_of_node(np, child)
-		if (of_property_present(child, "reg"))
+	for_each_child_of_node(np, child) {
+		if (of_property_present(child, "reg")) {
+			of_node_put(child);
 			return true;
+		}
+	}
 
 	return false;
 }

---
base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
change-id: 20240624-usb_core_of_memleak-79161623b62e

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


