Return-Path: <stable+bounces-80907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521F2990C98
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EE61F2198C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194F1FA26C;
	Fri,  4 Oct 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jycIQLQz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFA1FA24E;
	Fri,  4 Oct 2024 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066219; cv=none; b=Rc4zH9T7hJD6XnKWBIgY+g9+dLOHn+bgPKVwl7pmiVnWlg3z8VTBzaZfE82Nl0K7kTX03dH534fPEzt59Cc7U2YkqDf1zEHCO8fn4KhrNXLa5/6zhgzW2xw9ulOZpjNm96FaAC3m/8hFaZ6SwOa14WrK8tFkv3DfGYxNZ6TKFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066219; c=relaxed/simple;
	bh=FEr6mMq7J4msZ4yB+YFTNrkNfNp+VgGlsUzxwil8hDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjbdQTkjSxGXw3BbbZnqyjz6ZU0y/9CUcsdlAGQP6uV6Vu7qdBiCp8yGdOYqWyis7jYdKoMjf6zxJvt+O++xxkRL351XeU7Fv9oz0EinaMs11tnQhdll7YE+hWwBN6/xr0IM86zTWIPoilOw7rkkyui/sdAzXetAOXw9T680d/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jycIQLQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7652DC4CECC;
	Fri,  4 Oct 2024 18:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066219;
	bh=FEr6mMq7J4msZ4yB+YFTNrkNfNp+VgGlsUzxwil8hDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jycIQLQzLEzzeyyKFA0O290LQtD4RdfqutdKjerhLNT9i5fhNiZzzmqbWdLRDIndb
	 dbVXlW7qpUtwN/ztxDxpv2QFXcHJV8Gqj4ER+bT1pTcwWMscTv8VU0SQvH1B/u6K01
	 kGlLSWlT5U9WouJdXCzf5cBj7GqKoAXm42GpzeWfl4Gifg9rNlxudTH+z5Izgz6x+i
	 XtYG1/+E/FCNxZKK8Q/F9ttthtWe4S6ifyLYx/OI0rDrihLHLLt1r7h+NJkdT2q7Gm
	 jDae+J//ZNj7Y3JSe3FKpKLCB3tl5HXTc8MG4I89YeVcrBQ9MLBUadUT3AxLQ525LX
	 lHNMmsMz68imQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Subject: [PATCH AUTOSEL 6.10 51/70] comedi: ni_routing: tools: Check when the file could not be opened
Date: Fri,  4 Oct 2024 14:20:49 -0400
Message-ID: <20241004182200.3670903-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>

[ Upstream commit 5baeb157b341b1d26a5815aeaa4d3bb9e0444fda ]

- After fopen check NULL before using the file pointer use

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
Link: https://lore.kernel.org/r/20240906203025.89588-1-RuffaloLavoisier@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb2..892a66b2cea66 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -140,6 +140,11 @@ int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
 
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
+
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
 	for (int i = 0; ni_all_route_values[i]; ++i)
-- 
2.43.0


