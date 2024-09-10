Return-Path: <stable+bounces-74445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7347A972F57
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9232875FD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288AE18C325;
	Tue, 10 Sep 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJIk3jKW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97113AD09;
	Tue, 10 Sep 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961825; cv=none; b=WaD+QCaC0uZvxUZmZ5uyAJJs1U3Z5UrDZRldzHYF4Lqw8/c5lEgnvScceNGEJlibaj79XzAkYJLBo/iihlcXe5ohAaYBrT2JuEOCnWVArCNzBUSMPvKZTBcHt4Q/dRfKhEq2cHSyovOVsO4DM77rAFpu/juAnage0rQEbSRsqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961825; c=relaxed/simple;
	bh=8w0OPeXONOTMVSkc2sCDaPmGbmw5RHtZZBzzSa4Myc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kz69dJdul5XRgmKjsGBegzUIS7deOlxSfkssh+AFCS/I9cYhZe5FYq6nunaQoN/6HvxdtWqkXfZ3S49h6bKIty4+RFWfRWF0KCZlcnlCqnRpLLQnNfjA9mXQe9BB6jf9DZ5JQHlHIf53Su0RVRip8gzN708Ojkn/4lJVo99pfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJIk3jKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64437C4CEC6;
	Tue, 10 Sep 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961825;
	bh=8w0OPeXONOTMVSkc2sCDaPmGbmw5RHtZZBzzSa4Myc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJIk3jKWBbEYznCyvMbbPhEHSra8vMNwZ+udxtfQdB9zEAsOGu2QHqcNfISCr5F43
	 kS9y1zhnGcb2MqIb6x6+Sqb/sBDKf1vDLJbtk/GuW0CFsNbOFXBHDab0qBwOwfMsqO
	 eeIq1bdPPCT5uA8smYDZ9vpQc+4iah02kB+2NkNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 202/375] ASoC: topology: Properly initialize soc_enum values
Date: Tue, 10 Sep 2024 11:29:59 +0200
Message-ID: <20240910092629.287748180@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 8ec2a2643544ce352f012ad3d248163199d05dfc ]

soc_tplg_denum_create_values() should properly set its values field.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://patch.msgid.link/20240627101850.2191513-4-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 6951ff7bc61e..73d44dff45d6 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -851,6 +851,8 @@ static int soc_tplg_denum_create_values(struct soc_tplg *tplg, struct soc_enum *
 		se->dobj.control.dvalues[i] = le32_to_cpu(ec->values[i]);
 	}
 
+	se->items = le32_to_cpu(ec->items);
+	se->values = (const unsigned int *)se->dobj.control.dvalues;
 	return 0;
 }
 
-- 
2.43.0




