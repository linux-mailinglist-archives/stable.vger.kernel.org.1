Return-Path: <stable+bounces-174769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC54B36411
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462A67BE210
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945A340D93;
	Tue, 26 Aug 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SzSI18DL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494D200112;
	Tue, 26 Aug 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215268; cv=none; b=YQ/0g5UOiGwcKwAsP4XK+eaAVKbnegc1j3Fd8DSy+DqL0rJZ0VfaI8f2cqW5d6RTbfYPBQE+k43ZbdFpo46Y4hpCU2cXX3ulDu1SvyQ9xoU5vMFWL8suzgkVcZm9Sg0EUhbkkqkLXt7EFmtHpKL18qNHJ/F4wSMU3xq6w2GhULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215268; c=relaxed/simple;
	bh=lyuTECvXX6LEnt12sXajVcxsES8ggTVWCDoPJ7bxbYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6x/isEjM8HeehMY/ZgndpVT26qpEijbfACWp0U3/LFake8P7OO6Z1Mk8XW9FMZ45UiclmeMOpl4/UtsApm94EUJ/3ogBQ3hOJGlLhKvViMYVadT3lcA0c+UJk23a4lSEUPDPU6SP3hZzHmJUaZRd/9nLPsDpWUOmB/GPmDWwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SzSI18DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D087CC4CEF1;
	Tue, 26 Aug 2025 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215268;
	bh=lyuTECvXX6LEnt12sXajVcxsES8ggTVWCDoPJ7bxbYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzSI18DLXzB6pJo1kMP4rBEhVrP+4m856z0vMgovbeo5hZVHU8GMT4uPT+DewSEoU
	 rwyW9HX9hTdhfebc5ChBSYnmlUThbZWe/ALTpjy2gY/GmPEbZT9yl+ysW6nCsWjyx0
	 V9YG+eqjOEQCMITrmt2nuj1ktkMqMeEl5uN7ngC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 449/482] iio: light: as73211: Ensure buffer holes are zeroed
Date: Tue, 26 Aug 2025 13:11:42 +0200
Message-ID: <20250826110941.921893206@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 433b99e922943efdfd62b9a8e3ad1604838181f2 ]

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250802164436.515988-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/as73211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -573,7 +573,7 @@ static irqreturn_t as73211_trigger_handl
 	struct {
 		__le16 chan[4];
 		s64 ts __aligned(8);
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);



