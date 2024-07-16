Return-Path: <stable+bounces-59975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3E932CC7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C161F2465A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222D719E7C6;
	Tue, 16 Jul 2024 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1bIgRpZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F31DDCE;
	Tue, 16 Jul 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145478; cv=none; b=Bcxbvfp0kN9PqeBljn6jQySBL9K1eVZjly9WukyfHVH/UvMSJvOzNMxNCRGddob/bMhhgFSTXz3oRKRI1wsMknuhnZDgz/0De8A8WblinD9AKZjr07kEOgVUna2bd0oHlu6Eot4MnNeqoEleQv+s90uDvocxep3unDfLzNaoG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145478; c=relaxed/simple;
	bh=bZlItLHhCmbpaEhx0R0geBZh6v7pSnGoQSlEj2UxELI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oobWEE9caE4bhCNbcWO3Ej95TblpoaTVoy1JyEeXDMDPRhWhus/Rb2sK3BdpQa1eXQptLQseKbDVgDMaKuhNwt7dpqhFhLVVGoLlEr/huOPkCGmCh5qg0wS47spZxrKOLoQCDAPAV+1fConYkJ1rshvaOJZvxH8+yVqgyeXi7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1bIgRpZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EBFC116B1;
	Tue, 16 Jul 2024 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145478;
	bh=bZlItLHhCmbpaEhx0R0geBZh6v7pSnGoQSlEj2UxELI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1bIgRpZ9JyNA9dwOm9iB4kTFUL4NdXWgOzFcE7pt+m4qmBbAP4fatQF6BJlw4MTTX
	 3APgLKzsmgx10k6nKqT9s896bL2aHFr2QzHkaqIPa3DDKRqqsEaLzxct7tgcjHpKu9
	 KLOKS87L5M/YP2CNslFuLkpKIFV2Sij5GObsU2l4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.1 79/96] misc: fastrpc: Copy the complete capability structure to user
Date: Tue, 16 Jul 2024 17:32:30 +0200
Message-ID: <20240716152749.550944790@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152746.516194097@linuxfoundation.org>
References: <20240716152746.516194097@linuxfoundation.org>
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

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit e7f0be3f09c6e955dc8009129862b562d8b64513 upstream.

User is passing capability ioctl structure(argp) to get DSP
capabilities. This argp is copied to a local structure to get domain
and attribute_id information. After getting the capability, only
capability value is getting copied to user argp which will not be
useful if the use is trying to get the capability by checking the
capability member of fastrpc_ioctl_capability structure. Copy the
complete capability structure so that user can get the capability
value from the expected member of the structure.

Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240628114501.14310-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1603,7 +1603,7 @@ static int fastrpc_get_dsp_info(struct f
 	if (err)
 		return err;
 
-	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
+	if (copy_to_user(argp, &cap, sizeof(cap)))
 		return -EFAULT;
 
 	return 0;



