Return-Path: <stable+bounces-43155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F38BD6D0
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 23:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2709B2123A
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D515B969;
	Mon,  6 May 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="b3w0H/C6"
X-Original-To: stable@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359915B54C
	for <stable@vger.kernel.org>; Mon,  6 May 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030758; cv=none; b=qgaoGLHE9Jk3sh7NEw296Cf2uR5NNJ05MfSWRhSrY/iN5PUBqB9iuzoUvrwEt4xxsMJt+4n7FOBkjBVhMb/pDPQjYIK5wHDJS7BWcMk06hT6y+ChFAelKexGztN4jNDdQDOcYWtJ6DS8zfW2MPiTR3H0heIkato3YmdNCwcOMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030758; c=relaxed/simple;
	bh=sB2TiapAd1rKXPpOcjtUFNGCP+rlUWgkgcfUP5iX1FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G78WkplebJAwMq+628Z6aZc9E9Xu3mVrtOU8t5ybArkgNDVWoHDA4KH2PbVL135976kD/6AtB5heqrRJUibq1vgJtsWvk0TCNu3fxM3sJJxgNRKyLcwNrRt0fka2hQ5p4HKsGeXuMjj3fwxE0V2r9kRohP0Mi82yU+nZfDnATlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=b3w0H/C6; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 32B87600A2;
	Mon,  6 May 2024 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715030753;
	bh=sB2TiapAd1rKXPpOcjtUFNGCP+rlUWgkgcfUP5iX1FE=;
	h=From:To:Cc:Subject:Date:From;
	b=b3w0H/C6b6Co2SKKTvBnO73tG5EV2nbDK7mB67nNALM8kAkrQZtYkTYdW0ZQNS++M
	 ipodtTXpP2Gzl7p+dTI1NjluoCbQ1tCYxdLi2+JIWTZ9qTqWkafqf8S+0/zfuYYegA
	 BrME9JDwuA7FzB31mIFaRREQKOCQ1cQCaaFVM9VailinZjyU1NdHtPH0DEhQWZgT8A
	 3QXUCm2ZjuofcoSYmylyE1KEhTPWDjrL6JnfNTmSkYSUPOX8Bgb++qu/MOOy2rHnPq
	 1xKf2JG8c7jU7km81UV1e2x+Ujm6oX18v37TpyYYMue0MAuIovq7MX236LS+Vc7AYY
	 HU1Mi7hZWPqtw==
Received: by x201s (Postfix, from userid 1000)
	id 30E1820314C; Mon, 06 May 2024 21:24:35 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
Subject: [PATCH 5.4.y 0/2] net: qede: return value conflict resolution
Date: Mon,  6 May 2024 21:24:21 +0000
Message-ID: <20240506212423.1520562-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks Sasha, for picking these fixes up. I have reviewed all the
queues and everything looks good.

Just for completeness sake, I have fixed the conflict in v5.4,
so it can also get the flower patch.

Asbjørn Sloth Tønnesen (2):
  net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
  net: qede: use return from qede_parse_flow_attr() for flower

 drivers/net/ethernet/qlogic/qede/qede_filter.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.43.0


