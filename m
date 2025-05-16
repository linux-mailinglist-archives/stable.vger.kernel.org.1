Return-Path: <stable+bounces-144631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6077BABA312
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4996D3BEDFB
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C23278766;
	Fri, 16 May 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ppkW92LQ"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903D1A3159
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420933; cv=none; b=HFvjmu+liZWUjYc7ExBCQC7iLICZDqyG73byJMEGKDcXOLNxYnb5meU1RGzrbgocHJp4k3hFiK6xSYrWMPIPy0wYCQYU3VIq/U7LWIxiYhGYXAkBZGI/wbM/iw64fKI2bfnBwJCOnaBYHA8/frWm4m3JTDeEleATdAGAkDyA8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420933; c=relaxed/simple;
	bh=Cqr80KwBXMMP4q4HFLziWW+h3qcKojnAUW/dZ7tULMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uq/n6zDxlTKE+WGE0ftWWbBnoVevJ/DonAH8B+BDDe5f8u+pPrPY5P2CJO4JUecxzmlO/vXbz8SC9NYROjz4ncE0RmYPWQAM3bpcnHPHHiMa+vND/8LVYhO4sxX7XrU8N6eLtMMTad18l0aWhGeRV18xHo4TBjdBzzSrpFL3dwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ppkW92LQ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B527F42E81;
	Fri, 16 May 2025 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747420922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3KjtmfZ5dbnvNE2Mu/d2J1GvSHPIiH8XPax6TaCxs4=;
	b=ppkW92LQohXJFvXPGEgfGlV4MaihiH+mkOj2OnX/zkLoHfXwd+9mAW/DSkmhSjN36P8y0G
	HtmrM05wmB+8PZF/iosTZ5hggZ2Ki/KtlTRG98BziAwDfAMqWF7SJPBLSPwt6tIB3DS0f0
	TewOelMd1CUBRv30Z4tuUYA2xDwCvjxGEdtLYnNVmaBDDmTCyVqOwgdpIq8y5y2/fZMjnQ
	tUZAtzjjqnpwfSF9yVoIjzgiYVVpaoFXbnmOHjy6wmg12pTYM8mGOoMi3fwcYLjv2YHi7k
	WWhCNxX46RCDcmDJEnlGjolftC0M79UwLHYKXeZ6iEIzKn/6JLAWaTY6VpNppw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12.y v2] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Fri, 16 May 2025 20:41:53 +0200
Message-ID: <20250516184154.5622-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025051215-economist-traffic-fa57@gregkh>
References: <2025051215-economist-traffic-fa57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeuvdelkeekteeuiefhvdejfeegleevfeelteegleejjeekueejfeeutddulefhnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrgeeivdemudgsuggumeeluddtudemvdelgehfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrgeeivdemudgsuggumeeluddtudemvdelgehfpdhhvghlohepsghoohhthidrfhhrihhtiidrsghogidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhis
 egsohhothhlihhnrdgtohhmpdhrtghpthhtoheplfhonhgrthhhrghnrdevrghmvghrohhnsehhuhgrfigvihdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

[ Upstream commit f063a28002e3350088b4577c5640882bf4ea17ea ]

The threaded IRQ function in this driver is reading the flag twice: once to
lock a mutex and once to unlock it. Even though the code setting the flag
is designed to prevent it, there are subtle cases where the flag could be
true at the mutex_lock stage and false at the mutex_unlock stage. This
results in the mutex not being unlocked, resulting in a deadlock.

Fix it by making the opt3001_irq() code generally more robust, reading the
flag into a variable and using the variable value at both stages.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit f063a28002e3350088b4577c5640882bf4ea17ea)
[Fixed conflict while applying on 6.12]
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/iio/light/opt3001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 176e54bb48c3..d5ca75b12883 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -692,8 +692,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -730,7 +731,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)
-- 
2.49.0


