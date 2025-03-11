Return-Path: <stable+bounces-123809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD105A5C778
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02358189B5F2
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87525EFB3;
	Tue, 11 Mar 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OM0XAg95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C325B69D;
	Tue, 11 Mar 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707026; cv=none; b=cMmRnIrJaDKziiopz59eIykTuxmdvtQDAcXzJ0XeaweEL80RSiCDXSlm8CFEE/6k+/LJAPGmoXrtvqZMuie46dTZ1La0yDB1MDUIN6SILxoHTST+FxJSzmnKnxy2IkVaqPTXA98KTTY8g5vOq77vONcM6TSFB+MVWKVkXjlIdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707026; c=relaxed/simple;
	bh=WWw421XK7/5Ya0jagdc3KiCGx7WkRUzi9Zbh041YCcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWWtLtvyexFgRnOP+Jc85fIzkndSauoBAHUAMLFrHIjxBWm4ocf8/EF8dG2sUyiApowIBBcjehf35J/hY5TUxcclzqTQIEw/7Q0KT7OjjEUv6Dd2ofG9NZjWfhHW72bLA5T8HoIHbKAdXppN8oSnLvlXbQpqYkpGJVz6c+o9aoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OM0XAg95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80A4C4CEE9;
	Tue, 11 Mar 2025 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707026;
	bh=WWw421XK7/5Ya0jagdc3KiCGx7WkRUzi9Zbh041YCcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OM0XAg95x1+Kd5/JJiux+1wPzo0+iX2Yf63Ea6SfHHBzhI9MP3t0GmG6ynyBAmE9Q
	 zpiwuE/RTCZ4hOMGmOFFLrSrEpJ/95MsOgBipTALlHi+pqScytF2OaOJiw6Bk2cWjb
	 dVrBCjIih1BqVYtDqYJi+dFjEuViL/q49sCe1ZMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 217/462] NFC: nci: Add bounds checking in nci_hci_create_pipe()
Date: Tue, 11 Mar 2025 15:58:03 +0100
Message-ID: <20250311145806.938082424@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

commit 110b43ef05342d5a11284cc8b21582b698b4ef1c upstream.

The "pipe" variable is a u8 which comes from the network.  If it's more
than 127, then it results in memory corruption in the caller,
nci_hci_connect_gate().

Cc: stable@vger.kernel.org
Fixes: a1b0b9415817 ("NFC: nci: Create pipe on specific gate in nci_hci_connect_gate")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/bcf5453b-7204-4297-9c20-4d8c7dacf586@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/nci/hci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -548,6 +548,8 @@ static u8 nci_hci_create_pipe(struct nci
 
 	pr_debug("pipe created=%d\n", pipe);
 
+	if (pipe >= NCI_HCI_MAX_PIPES)
+		pipe = NCI_HCI_INVALID_PIPE;
 	return pipe;
 }
 



