Return-Path: <stable+bounces-41903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB928B7062
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643E8B21BED
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23A12C81F;
	Tue, 30 Apr 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DM3bdZ2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D74E560;
	Tue, 30 Apr 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473907; cv=none; b=M9PllgajecfzshA4Lpy9wX0yc6KfDO+amQDY0QtdfEzfsJQV+IDNZPsUkUmWxWAbIoU2fGloW0vtUEhAUk6x0uv3mmCUMzIOsnhImlhQM3OBupYsWELOSmPYCLjw9rFRfw9hvJovnoaJ5Rk34VVlguZpPO5HuBo2fgJuJzBG4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473907; c=relaxed/simple;
	bh=Skei5rLXynn9J6pvRUw2QJPdQKjVzTIEuf5JFwzI9tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frtM56pVwBoHaxiS6csCE/wwl0kUdEvDWcdXLIU/Eck4rF7CgNWZCUGGT6OZte6LgCDv/wgydGhJMF6aD/SzotK9oxCeoTcp1ZlqEdNYEi4ED/aCkMf6eDnSzFYnq3qqlkvLbm/8Rilhx0uIhHCl/MLASbyzJyf/TuJlWx0+CGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DM3bdZ2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2A0C4AF14;
	Tue, 30 Apr 2024 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714473907;
	bh=Skei5rLXynn9J6pvRUw2QJPdQKjVzTIEuf5JFwzI9tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DM3bdZ2ekzZ8pzexgbocrEGBxlpAI6V5xIBTXGesgHDCbJuXUTHx38ZizWyR6VnhR
	 u3kNYcQOfqLDUxJRuDVIHFLA7t9wcN3Kt5oB5hi8XSn3wdHBRcM3YCPab/lQcljww3
	 7RruJBa3QeRp2d6vVR03pr/a3H8JJIuhiJ3ZZeZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 58/77] Revert "crypto: api - Disallow identical driver names"
Date: Tue, 30 Apr 2024 12:39:37 +0200
Message-ID: <20240430103042.850564846@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 15a67115d487ea5cb8213915a4f75f58adb87cbc which is
commit 27016f75f5ed47e2d8e0ca75a8ff1f40bc1a5e27 upstream.

It is reported to cause problems in older kernels due to some crypto
drivers having the same name, so revert it here to fix the problems.

Link: https://lore.kernel.org/r/aceda6e2-cefb-4146-aef8-ff4bafa56e56@roeck-us.net
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Ovidiu Panait <ovidiu.panait@windriver.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/algapi.c |    1 -
 1 file changed, 1 deletion(-)

--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -231,7 +231,6 @@ static struct crypto_larval *__crypto_re
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
-		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}



