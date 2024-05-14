Return-Path: <stable+bounces-44409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD88C52B9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC0A1F224F8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60212FF60;
	Tue, 14 May 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XKD/i6VQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5A7FBD3;
	Tue, 14 May 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686079; cv=none; b=WIdcPlpdrKj5JdAkTRwwoBYUZiUXklA2INtwsu4z6IzgvxfImmFC2zPphcdOv+XfhGcvjlymgHcJQXxCJ8WhsOHeUP0DYallSvc/TK2xpUKt9Mm9hCZFhdLADu1w97f7NSgEmDRJq4+aoVikhzOlKiuoxQvXaOvEK/eBaq6xME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686079; c=relaxed/simple;
	bh=fWkXPuKn1sBgzjcEHzv1jFIqVjN1+mZMBqX4DnzIb1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMe2hIwJ+gvM1FNpv2FRoUfJ3lhhXeB8OSq9Jpa+3Ehvv94Ov50IyZunu4T3VQrBZbbhJ1jDD40Bwk3TOTi4WqSN4tf0b0wWTVxR93CiBUcYdK2iZMkq3hmEJdWU56GRU+P3nTxkLHILOkDj5rQevcD3HQXYtLI6agQ6053PIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XKD/i6VQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960ECC2BD10;
	Tue, 14 May 2024 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686079;
	bh=fWkXPuKn1sBgzjcEHzv1jFIqVjN1+mZMBqX4DnzIb1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKD/i6VQQWFtu8hKpFh/vuFL1A/QQP7z+Io7tjORfydKNpWTmQKg69U2AY31wF6bS
	 PpzrOmhLDBinHGX+W36r/tNHI9aKtzIF+/LsEOJLdkue4ocf/ixBx89EhxlArGN/yD
	 asDY++rYHcklTRur5IcZX9wqUMNOmg0KTHe5p/Ao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/236] eeprom: at24: Use dev_err_probe for nvmem register failure
Date: Tue, 14 May 2024 12:16:07 +0200
Message-ID: <20240514101020.532141454@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit a3c10035d12f5ec10915d5c00c2e8f7d7c066182 ]

When using nvmem layouts it is possible devm_nvmem_register returns
-EPROBE_DEFER, resulting in an 'empty' in
/sys/kernel/debug/devices_deferred. Use dev_err_probe for providing
additional information.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: f42c97027fb7 ("eeprom: at24: fix memory corruption race condition")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/at24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 938c4f41b98c7..5aae2f9bdd51c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -761,7 +761,8 @@ static int at24_probe(struct i2c_client *client)
 		pm_runtime_disable(dev);
 		if (!pm_runtime_status_suspended(dev))
 			regulator_disable(at24->vcc_reg);
-		return PTR_ERR(at24->nvmem);
+		return dev_err_probe(dev, PTR_ERR(at24->nvmem),
+				     "failed to register nvmem\n");
 	}
 
 	/*
-- 
2.43.0




