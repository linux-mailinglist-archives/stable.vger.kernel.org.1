Return-Path: <stable+bounces-1551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0737F8040
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B241C21550
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6FB364DE;
	Fri, 24 Nov 2023 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o30OI0YO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479C364A5;
	Fri, 24 Nov 2023 18:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AA3C433C7;
	Fri, 24 Nov 2023 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851682;
	bh=PBI0N4EKOKE1jTCtfpl1zJopt1jtL3MXHdsp7Y1ogfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o30OI0YOw632MjmbLyHnn74h6hU+pL3ezCm2gVRh4SlDnHRcaUFTou42BUFisuTBg
	 Z3McLvSbkw8su2jzbPL97tGEIhNfS/kQQwTsuuMiF/oUOOGLn2661AqPUsoc1icboF
	 Jc58bym1D79aXmGufpEr0Fzs0jRcS4OsO370OA7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/372] platform/chrome: kunit: initialize lock for fake ec_dev
Date: Fri, 24 Nov 2023 17:46:56 +0000
Message-ID: <20231124172011.451595736@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit e410b4ade83d06a046f6e32b5085997502ba0559 ]

cros_ec_cmd_xfer() uses ec_dev->lock.  Initialize it.

Otherwise, dmesg shows the following:
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> ...
> Call Trace:
>  ? __mutex_lock
>  ? __warn
>  ? __mutex_lock
>  ...
>  ? cros_ec_cmd_xfer

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20231003080504.4011337-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index c6a83df91ae1e..b46a8bc2196fe 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -2667,6 +2667,7 @@ static int cros_ec_proto_test_init(struct kunit *test)
 	ec_dev->dev->release = cros_ec_proto_test_release;
 	ec_dev->cmd_xfer = cros_kunit_ec_xfer_mock;
 	ec_dev->pkt_xfer = cros_kunit_ec_xfer_mock;
+	mutex_init(&ec_dev->lock);
 
 	priv->msg = (struct cros_ec_command *)priv->_msg;
 
-- 
2.42.0




