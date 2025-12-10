Return-Path: <stable+bounces-200639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63400CB2451
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 700F23064501
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EAD303C81;
	Wed, 10 Dec 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iSAfcHAZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3632FE04C;
	Wed, 10 Dec 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352102; cv=none; b=U8OzTFrDYE3vLsp6OCrIMxoQUfO1ek80Ya14yVwU7SgbV/4eTOheHd4iHt/QaEy0CApZFrBiVeWo9fYe1xX9upQ72/XcRM9clBytB7DX7r8896fpUtd33YuuAHIO+kTecB/qxz6JeCrS0OF4b9l+cPJnwSNv11ZhnH8Xh+HGeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352102; c=relaxed/simple;
	bh=hsr++WdnqnAmb1w2m0h/elNZgp0XMIdQdfDFA6G8FIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuxMnMhjqhE9XHJTJlurx9yaKGUQD/M1FDeMDUwPYulBL36Snt7TsfUt2yOC0/PAmIACS0Rn79AjbA1WJMGPpVJt55KyfukrRrO5C6z2rPAHMMpmgOdxhRAW/f6H8GH7uQKQyIZ+9Q208pcNWlgy/QlPXmZfwpd6By6OMKauxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iSAfcHAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B04FC4CEF1;
	Wed, 10 Dec 2025 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765352102;
	bh=hsr++WdnqnAmb1w2m0h/elNZgp0XMIdQdfDFA6G8FIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSAfcHAZXqFqFYjho8ADq1bt/snaSrY2/Q2d7aw7qHmjcrHElAxynuLtn72OHWbmS
	 6hqsv6kGENe8PD16r61dMbGfPB4KEKAJgvi4NOcqhluM8hDak83KO0xdXq2M5i/eh2
	 Er4kKUTk58gs7GzgAL5hxWs9kdjbRZ/4hn2bccss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcos Vega <marcosmola2@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 51/60] platform/x86: hp-wmi: Add Omen MAX 16-ah0xx fan support and thermal profile
Date: Wed, 10 Dec 2025 16:30:21 +0900
Message-ID: <20251210072949.137335584@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
References: <20251210072947.850479903@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcos Vega <marcosmola2@gmail.com>

[ Upstream commit fa0498f8047536b877819ce4ab154d332b243d43 ]

New HP Omen laptops follow the same WMI thermal profile as Victus
16-r1000 and 16-s1000.

Add DMI board 8D41 to victus_s_thermal_profile_boards.

Signed-off-by: Marcos Vega <marcosmola2@gmail.com>
Link: https://patch.msgid.link/20251108114739.9255-3-marcosmola2@gmail.com
[ij: changelog taken partially from v1]
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index e10c75d91f248..ad9d9f97960f2 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -96,6 +96,7 @@ static const char * const victus_thermal_profile_boards[] = {
 static const char * const victus_s_thermal_profile_boards[] = {
 	"8BBE", "8BD4", "8BD5",
 	"8C78", "8C99", "8C9C",
+	"8D41",
 };
 
 enum hp_wmi_radio {
-- 
2.51.0




