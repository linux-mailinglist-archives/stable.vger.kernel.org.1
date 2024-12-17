Return-Path: <stable+bounces-104407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECE9F3F4A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 01:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD77165386
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32164D599;
	Tue, 17 Dec 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAR2OQpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357E15AF6
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396140; cv=none; b=TrhdQCV3HVUkkjKgZ4Rh9yHf/j0/A4espSNprUGl+LlCtG2S1s/6FingMoV2+8/lAWTeBT+XpIWPadKGc+wNBIA3Q90dN/yvr5txvXUTcJ0B8aqgks7oCPIWeG6UWFtVw++rr4nWrBB4WRqXTB6Bo78bcudp9xnr0A+7oi267jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396140; c=relaxed/simple;
	bh=uZLTA2JkzO9QN88exQSRJacbk3enNwQ4DxMhRM/SZK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6VJ+faKaYT/0YH3itYsLPhWqT1QEoO1pBRHjkFaBukVJVCG55m9+tuROA+XPlEOYM96YzATi1+xD/sb/OYa8NSPi4UN7+uHbgQH81t4lpepEhdH3uqB/tjnv9/yXXeI4rmKH/L7hh4fnatvc18shOUzNflhQrGOQ0Q9ZhUoIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAR2OQpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD232C4CED0;
	Tue, 17 Dec 2024 00:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734396139;
	bh=uZLTA2JkzO9QN88exQSRJacbk3enNwQ4DxMhRM/SZK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAR2OQpaQ3/FjWSRO6ZziH9wPNDRWJOif00tycR/B5Qpu4tzZg1xsg2kKyLYPi4PU
	 EOy7e00Cm1BUE8injjKhd/SVIos0MgPTkI2zGngk4vC8GMzvuptbZhXAQOiGM3cIks
	 HAPmc/3KTCvfqZ3YUWGJwcNZtScapR6Yy63xpZdsGXtXSW11VveQ6y2yUqD4qhTPwi
	 FTFMXJqwq+GJxAG0KacjO4bTGTxZk6hM/YdG/yVWjdiWbiy/+jffAVxnx80XKIQTij
	 yVTmBT6nwyr8jhfJaX0WeW17LKGiXiXNC2BNrO4xNn61KuizylieXMG97NFcAIBpFh
	 oiJEgmoowqfTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tanmay Shah <tanmay.shah@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2] mailbox: zynqmp: setup IPI for each valid child node
Date: Mon, 16 Dec 2024 19:42:17 -0500
Message-Id: <20241216192841-922fe76161366e54@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241216214257.3924162-1-tanmay.shah@amd.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 98fc87fe2937db5a4948c553f69b5a3cc94c230a


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  98fc87fe2937 ! 1:  7d2de1d13592 mailbox: zynqmp: setup IPI for each valid child node
    @@ Commit message
         Fix this crash by registering IPI setup function for each available child
         node.
     
    +    Cc: stable@vger.kernel.org
    +    Fixes: 41bcf30100c5 (mailbox: zynqmp: Move buffered IPI setup)
         Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
    -    Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
    +    Reviewed-by: Michal Simek <michal.simek@amd.com>
     
      ## drivers/mailbox/zynqmp-ipi-mailbox.c ##
     @@ drivers/mailbox/zynqmp-ipi-mailbox.c: static int zynqmp_ipi_probe(struct platform_device *pdev)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

