Return-Path: <stable+bounces-75582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F644973546
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F843289FE7
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266F18DF8F;
	Tue, 10 Sep 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RE4gbIpt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC418DF72;
	Tue, 10 Sep 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965155; cv=none; b=YMH1p8K9VKyhAPLwL4RAdDFcYacOSBdjXg6UEMUqVCSl+rUAWBxAGGm/Rj+lhMC6PW1xTC7EMCZ6CtoQvLPRICiVxM0tJeahkNUwxpXkLnuYCDWkyhatzuh/si6ZJvvknEW5LUh1QDO8DZs+6FxdpQVzGU9Nm/UmdXUcU1ZFgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965155; c=relaxed/simple;
	bh=qzWz3+VLHO2MiD7hULRDXDysXNOr+dY1JyhVT46nDhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4fFaFUSbAo8qw1ox5HANH7h0iDIBe7LbSWLOy8PWzWeX2mScLz2m96tHTQosiEekg92b7ECfBpYpQ+VxfRMQ7pgDRoqFa6BgjhauwMlx8+jTNvtO2jndn43zfgIo8Xhkg/iNxagAcmxdM+e+5BoOuueaeP0INjfB7JepyiFHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RE4gbIpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B547C4CEC3;
	Tue, 10 Sep 2024 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965154;
	bh=qzWz3+VLHO2MiD7hULRDXDysXNOr+dY1JyhVT46nDhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RE4gbIptJWHKlmwIuet7CDlQsRmUhk8rNo7z2DnqmNdoGWG7oNYNcGVYSIwxkovmD
	 7ATW6H4fJCL5voEQ76gTA3wfZdWHaWeNNwsVGNTkSMgAnWdbPMqG4sF1jvjdqsKeJs
	 64n0eRZQvbw5HiPU03wPCQU9sBBjS8vjGnzAZPvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 128/186] ASoC: topology: Properly initialize soc_enum values
Date: Tue, 10 Sep 2024 11:33:43 +0200
Message-ID: <20240910092559.844945012@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 23a5f9a52da0..aa57f796e9dd 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -998,6 +998,8 @@ static int soc_tplg_denum_create_values(struct soc_enum *se,
 		se->dobj.control.dvalues[i] = le32_to_cpu(ec->values[i]);
 	}
 
+	se->items = le32_to_cpu(ec->items);
+	se->values = (const unsigned int *)se->dobj.control.dvalues;
 	return 0;
 }
 
-- 
2.43.0




