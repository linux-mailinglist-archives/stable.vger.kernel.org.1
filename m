Return-Path: <stable+bounces-155815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91CAE43CD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9FA1BC0219
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED02517AF;
	Mon, 23 Jun 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RC5x1eHa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AA13A265;
	Mon, 23 Jun 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685400; cv=none; b=C4NqqKn/uOmXrsaNekfFIHZtX64rfUiAWZYQruUwNq0zCQJtDxdiwszJGZF3HWXn8GwWX5p6Kp9sh5+ZYiqZTmBjbQXOaS/8MkuFMOtBa9njYVgLGmmlGVYunIgjEY9Jk9NP8WPeTPfXDwAc5hkisEwKNf93IBpAnzt+Tay5wwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685400; c=relaxed/simple;
	bh=M07BejJdTig+I7o1xxFKmusaM1VVoRETen3cEV9HmN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr60MTDyUSY3veFUG48RX/t6lfc+lC1NEIzd/1GqlVyR626j8TqjiN63cDZX45+SqdXMekEtAoWvYjP5aP0MBMleJXJNx/M2hHCieecRtq8h8TvJZhujhgjooxwwXMd+Appv40J1WIr11n8yiTcbWq4R+mco7QOV7DRC0q38ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RC5x1eHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A101C4CEEA;
	Mon, 23 Jun 2025 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685399;
	bh=M07BejJdTig+I7o1xxFKmusaM1VVoRETen3cEV9HmN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RC5x1eHa8yP5y5udOcOLPokV8xjyN2UmZJI2q12cphbrEmvOosEtbBe0uurydISXT
	 RxS3B19BtsN/tqzR0VN5HWbvdwZDUzm1zoMQXsVqAJDCUWdEhkVk+3cUUaXt5LozyQ
	 n4qjvOu0/srlOP1yV8Z6jwuJhNq2E5LKcEbV57KI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Hewitt <christianshewitt@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 005/290] ASoC: meson: meson-card-utils: use of_property_present() for DT parsing
Date: Mon, 23 Jun 2025 15:04:26 +0200
Message-ID: <20250623130627.110069476@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit 171eb6f71e9e3ba6a7410a1d93f3ac213f39dae2 upstream.

Commit c141ecc3cecd ("of: Warn when of_property_read_bool() is used on
non-boolean properties") added a warning when trying to parse a property
with a value (boolean properties are defined as: absent = false, present
without any value = true). This causes a warning from meson-card-utils.

meson-card-utils needs to know about the existence of the
"audio-routing" and/or "audio-widgets" properties in order to properly
parse them. Switch to of_property_present() in order to silence the
following warning messages during boot:
  OF: /sound: Read of boolean property 'audio-routing' with a value.
  OF: /sound: Read of boolean property 'audio-widgets' with a value.

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://patch.msgid.link/20250419213448.59647-1-martin.blumenstingl@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/meson/meson-card-utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -231,7 +231,7 @@ static int meson_card_parse_of_optional(
 						    const char *p))
 {
 	/* If property is not provided, don't fail ... */
-	if (!of_property_read_bool(card->dev->of_node, propname))
+	if (!of_property_present(card->dev->of_node, propname))
 		return 0;
 
 	/* ... but do fail if it is provided and the parsing fails */



