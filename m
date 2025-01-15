Return-Path: <stable+bounces-109127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0CBA1225A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 12:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41751881E4A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C02A1ACE12;
	Wed, 15 Jan 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ithcGPOZ"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB21DB142
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939962; cv=none; b=JznZBiIST2e12KvTdopT5EG9EkSTQmHtyv6y55CfhmZ++WIpXoxQNL5V/XCQUPfrs8SE5IeM+nlcbR5r2l+tx+mEhsP9VxOo6MhsfdToZ1oV7yKWd67YzVhHVqUxV21Vfs1HiKbJyb1/0k2R2h0DJDX0EJgtjK3wpKQV+AovSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939962; c=relaxed/simple;
	bh=gbACNpu7iNTTzfKshi51iOH9bMDNnp9ZlkWAmqXENdg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=K1Ur76rokzhOZgh09mVi0YGn6vWx2UCPl7jKJCECfqo1OQfwgw/NhI2TIAk0V1zyN0Dd7A4SF6clusvUflRSl5+8/+uKf2uQZp5YFSwnvV7hpJgcUX0BWOxNAe4KeaCTFFCMDa5K/S/vGef6aEbSztT0LlVzY3stdYzRa/zAS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ithcGPOZ; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736939942; bh=5NbZZxGtxUOhivPvtivF3wSSkb5YMkM2PQvw0vUubSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ithcGPOZEarYyqD44D1GWES4KRk5feKP7fZmfOVtHWpvMu8M0LsuQrpV0VZzp1MIe
	 Mxbg4NYpcD4k3T5X7tclSkk9vHj+ZpcV772mX75QX3HIzks/yVOOmT4mRLzYgJib8+
	 /5IpLqoWQi2ffmqNiVH/JNEi04DL/s3qPYQO6w1o=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id 4A333C09; Wed, 15 Jan 2025 19:18:35 +0800
X-QQ-mid: xmsmtpt1736939915t94lxco0q
Message-ID: <tencent_C1498A587BE144C04035BCD022D5307F3C0A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieUzZ7l3EfCoQZyCO+jyZMc09ww2sd+JG+CKtKWU0Sydm7O/xhmn
	 kEfM3obHmjLCg3F9T44fmjXZV64J33lCqCSLgxsB/jkTQ2GFZPNFVKgyVjHb5ost5jGnZcBQ8Zhp
	 I+/Y3T3UlZfJ9zvN8+uFHDsNYe5YHDHf1xSdE22k+Y8x/9UKpLtoXZBhAF3d/ZaMf97bhP78Mv/1
	 9haAcjpCP0rVaYyHsDf7Ax/YmM5thtwEcO6uFx0zae+aBf98/SpUH0U8M6pe1W+at/V4Xemqg9rL
	 oM0egeLmGTNfHmZcQ6wug4lyzIkgfth51+uIJRSG0A2A8MxW8BX3BsTDYUdl8GlBU2tDV5f19aNI
	 14MZ89F8AonxxKt3C20HQaAPLvrWPXsFYmsur8MS11TekhNnehvVuQMWUr1i92ezTosMse/q4rcL
	 XDkPP6JWqojk0m1PuBy5kQENzQRtRoJJ17M2maSrFssWy2g93N9TN7f3lhWU/PY/6kEnMsYkzHgb
	 UoEknpd0ByVC/YHD/N5Fr8qbRR58n2j0wNK+UmbmSKQqzcZ4kBQ8JHp6Hls7NIJXbOEIszfeb9Tq
	 eBsPG7Dcdrse7PEfZHiYHdc0SRH16OX355kFtzYpUdagQDCElArUGcR9XK2iWUGVP12bqutCmdB6
	 W7WJHj58Xs6393aL/c6Lz8wXuiHEgWSxSqr1jpv27CXApONLdqMR22Ukpzh3LejkQROgQ77UYCr8
	 NEMxoiwRTohbjBn5Zh3MH7olvfjRtNL68JqJqkCrn85FAGMEf27jkMALsX5KuOiAmwTnAHtUrNbz
	 Wx/7mN8zF2qj0RgL3r5xb+pSDOvlajvGzkIOJte/amkSNQhTbhTGMq2Xt8RFpMVTJ0A+mOuUWM9c
	 lDwdv3RiejvGL2nBMs0priXcg77150kalj5iT7kNfdtiTpzq6LgRYC/bsGo34ynP+be0y2mUpp87
	 L1xl8kCl4zEro6/U3eyHY2rLRjLdeJ+k9+9MDhXSlv1Ru4v9+QGMypu5ISYoR4Grm1Q4KY9rM=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 6.1.y] iio: adc: rockchip_saradc: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 19:18:35 +0800
X-OQ-MSGID: <20250115111835.1433-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025011309-swab-bootie-b4f4@gregkh>
References: <2025011309-swab-bootie-b4f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 38724591364e1e3b278b4053f102b49ea06ee17c upstream.

The 'data' local struct is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 38724591364e1e3b278b4053f102b49ea06ee17c)
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 drivers/iio/adc/rockchip_saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index b87ea7148b58..0861885fa2a5 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -270,6 +270,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	int ret;
 	int i, j = 0;
 
+	memset(&data, 0, sizeof(data));
+
 	mutex_lock(&i_dev->mlock);
 
 	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
-- 
2.43.0


