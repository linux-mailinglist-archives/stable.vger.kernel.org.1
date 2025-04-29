Return-Path: <stable+bounces-138496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D96AA1848
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BB61BC2DAE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25F2522BD;
	Tue, 29 Apr 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R03P4MFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5A2459C5;
	Tue, 29 Apr 2025 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949436; cv=none; b=geHxIvZ3fyEE2PzlgJfK+nlq/2cEyhlQ91991OJcdUHqx7ELmLMDYYsd0Ch24mPw6RC50WnCRQQuG9MDWz/DRDERwgwYYcFiLawGI8E0L2hPJ+MZUvUUAgsikI7L1ft4+uvoMaE2rwTEIErUI25g4g/j8n1UDaSknNr3UazzVkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949436; c=relaxed/simple;
	bh=lcfeS8NqzUnPya10mc++yo+EUu9GhAF+yHF99f4am/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KozjCltoDtFYXHQ8QrfrtQtr7IE7FHS6VnONUc6uf99o3Km7XWLtMzQVgEus04sZ2mPCRnnl8y+YUXb30Oc2lXk5XDG4Ye+lGoAxa13q4EDW9X/Hx3tHF2JKHD4JulEsBp1s45obrqAuH7qkAsRKIM6tPoM9/xNv6x3ruyb3D2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R03P4MFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B51AC4CEE3;
	Tue, 29 Apr 2025 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949436;
	bh=lcfeS8NqzUnPya10mc++yo+EUu9GhAF+yHF99f4am/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R03P4MFmOAK6bDhiBOHAVNGzZONHAQSytzFi02CL/hP81luTaHNthJPwl3LnKhIEz
	 C22sueB8nRcUlY3ZAWGbTy7iqzk8HKX25sfUF6AkXvVWJKkUqvjXj/tUNy0iB03A+i
	 zHSqFcb1R78JomNYntZToL2bO7j8ekEXjtkKp/QU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 5.15 311/373] usb: chipidea: ci_hdrc_imx: fix usbmisc handling
Date: Tue, 29 Apr 2025 18:43:08 +0200
Message-ID: <20250429161135.902203607@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit 4e28f79e3dffa52d327b46d1a78dac16efb5810b upstream.

usbmisc is an optional device property so it is totally valid for the
corresponding data->usbmisc_data to have a NULL value.

Check that before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: 74adad500346 ("usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()")
Cc: stable <stable@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20250316102658.490340-2-pchelkin@ispras.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -509,7 +509,8 @@ disable_hsic_regulator:
 		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
 err_put:
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 	return ret;
 }
 
@@ -533,7 +534,8 @@ static void ci_hdrc_imx_remove(struct pl
 		if (data->hsic_pad_regulator)
 			regulator_disable(data->hsic_pad_regulator);
 	}
-	put_device(data->usbmisc_data->dev);
+	if (data->usbmisc_data)
+		put_device(data->usbmisc_data->dev);
 }
 
 static void ci_hdrc_imx_shutdown(struct platform_device *pdev)



