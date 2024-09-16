Return-Path: <stable+bounces-76387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0534A97A17E
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380101C2237A
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD44156F44;
	Mon, 16 Sep 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w+lCB4SF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E7156641;
	Mon, 16 Sep 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488447; cv=none; b=URPg7WZyUxVaSdhW6jjwcQPsicqKgSkFRYkmHb6ncCbJrZY0PIoJMWGeIwWzrccqWGx2jLlUuTLV5N87He/Kg8zVatU4JQtmddlCsVNp3dB0ODmEtSjhEF4FO+JRE7+jIT+z+wsHgE+6xS2giBBJISQYh60qrX1rKJ8sBHyCmhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488447; c=relaxed/simple;
	bh=W/tL8KNzGXOiM98wJwhhxVIfhtNH9WbOymJmltjwyOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyPGVtt3HqTl54h/10i/aCoZSfxXnxchi8zs8Rq5mbmZLbLD/uo8p/f4+Y7jw0xW/SueumGFxCAZRiUqaTSYGGa+Jc6N95OfI9OAsDiMxEpnsDztXoMVu+b7aPEgXbVK+q0ZhZfu++mFd6N7S6AZacW7aEeiJ2Znx01R20RuEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w+lCB4SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0C3C4CEC4;
	Mon, 16 Sep 2024 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488447;
	bh=W/tL8KNzGXOiM98wJwhhxVIfhtNH9WbOymJmltjwyOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w+lCB4SFNx6MipKCnYj9nzr1vBfnzpiZD3GOVn1+TOT3SrZRc6lL+7OGE0wPi6gbp
	 mYPauuafyLKsPrnE7ha3fN7MDGzPQ/wPmbmyA/qbJDkx0sLrsL3nlnoXMSIMEY2JKi
	 YUnKDVzhHzVB+CsanhSsYp0OWFbFypOCRzLtlmd0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 116/121] ASoC: codecs: avoid possible garbage value in peb2466_reg_read()
Date: Mon, 16 Sep 2024 13:44:50 +0200
Message-ID: <20240916114232.945445206@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
References: <20240916114228.914815055@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 38cc0334baabc5baf08a1db753de521e016c0432 ]

Clang static checker (scan-build) warning:
sound/soc/codecs/peb2466.c:232:8:
Assigned value is garbage or undefined [core.uninitialized.Assign]
  232 |                 *val = tmp;
      |                      ^ ~~~

When peb2466_read_byte() fails, 'tmp' will have a garbage value.
Add a judgemnet to avoid this problem.

Fixes: 227f609c7c0e ("ASoC: codecs: Add support for the Infineon PEB2466 codec")
Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://patch.msgid.link/20240911115448.277828-1-suhui@nfschina.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/peb2466.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/peb2466.c b/sound/soc/codecs/peb2466.c
index 5dec69be0acb..06c83d2042f3 100644
--- a/sound/soc/codecs/peb2466.c
+++ b/sound/soc/codecs/peb2466.c
@@ -229,7 +229,8 @@ static int peb2466_reg_read(void *context, unsigned int reg, unsigned int *val)
 	case PEB2466_CMD_XOP:
 	case PEB2466_CMD_SOP:
 		ret = peb2466_read_byte(peb2466, reg, &tmp);
-		*val = tmp;
+		if (!ret)
+			*val = tmp;
 		break;
 	default:
 		dev_err(&peb2466->spi->dev, "Not a XOP or SOP command\n");
-- 
2.43.0




