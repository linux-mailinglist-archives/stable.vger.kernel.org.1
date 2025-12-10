Return-Path: <stable+bounces-200698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9DCB29DA
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 10:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5FBA30255B0
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E6303C8B;
	Wed, 10 Dec 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAuUT4aL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15F27E045;
	Wed, 10 Dec 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360693; cv=none; b=qQDIcx1TzWgQ4HRYqogoV6+MPJP3yvk+++loQ8u54qyuP6qmoE7BUf+NL5ZHdUcquNTKYeb57x/sdCpl/BZzkX/4V/ozjIRzwVh1sDuZUmtdpahRczNkHlnlYXQKyuD9fSAPZ/6ELRb1ZCM0UXQ8c2yGd/68fvMbYmsNDmR4al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360693; c=relaxed/simple;
	bh=JZHmpG3KmRcucBEpb6iZ/rbIZ6/y3e6FvrLlH/dzNN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pavtk1M3mmijGclO1s6yWI2/EPomtvnWhe6XvFnHAe44/1VjjEyZuaqYHhMAfyOgyiYZQ61tbgx0djc5eCebPu5kGuc7ENAliE7GRRlMLRwooviOUt3mNWHU6SRxWsAf1G7VTDQ61T7VzLsKWsX+VNF2sYrOYvW78KH3rCZxdZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAuUT4aL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7092EC4CEF1;
	Wed, 10 Dec 2025 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765360692;
	bh=JZHmpG3KmRcucBEpb6iZ/rbIZ6/y3e6FvrLlH/dzNN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAuUT4aLMrHbDeqKMyTf6Z/aJdu9JLsDfiQLVavVrfalikcHuPWiEa/aiNFQw3q4v
	 Q7cjb6kvoE6VCioNIJ54FVe55iJ0NuQRpYv1DLZzSrDc5vdN2aDXlvouPHbHByJSBz
	 p4L2a03nRw9g6xfLpsBeUNxUkCaEnNXuZpkPzrZIk18DZBvwg4RSLB6uSX2RxF5Gk/
	 72denooaH8Oro969WNSFkqPUyCfHVPW5kOs1cDckJFDrcRiAbqLZHJl3+jpPl5WPyu
	 IK9KPDv0/QJdq0TEU/zOLF4JrjR4047HIenp4cqutOhoK085IhU9YWq3Q2zcnxUAWs
	 wfE0v9rKiqLzg==
Date: Wed, 10 Dec 2025 09:58:07 +0000
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, izumi.taku@jp.fujitsu.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fjes: Add missing iounmap in fjes_hw_init()
Message-ID: <aTlEL6sYdo8K2S2F@horms.kernel.org>
References: <20251210023243.47945-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210023243.47945-1-lihaoxiang@isrc.iscas.ac.cn>

On Wed, Dec 10, 2025 at 10:32:43AM +0800, Haoxiang Li wrote:
> In error paths, add fjes_hw_iounmap() to release the
> resource acquired by fjes_hw_iomap().
> 
> Fixes: 8cdc3f6c5d22 ("fjes: Hardware initialization routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Thanks,

I agree that this is a problem and that it was introduced in the cited
commit.

However, I think it would be nicer to address this using an idiomatic
goto. And that this is appropriate to do as the bug fix as you
are already handling all such error paths. And the code does not
seem materially more verbose than your patch. I'm proposing something like
the following (compile tested only).

If you agree feel free to incorporate it into a v2.

diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
index b9b5554ea862..5ad2673f213d 100644
--- a/drivers/net/fjes/fjes_hw.c
+++ b/drivers/net/fjes/fjes_hw.c
@@ -334,7 +334,7 @@ int fjes_hw_init(struct fjes_hw *hw)
 
 	ret = fjes_hw_reset(hw);
 	if (ret)
-		return ret;
+		goto err_iounmap;
 
 	fjes_hw_set_irqmask(hw, REG_ICTL_MASK_ALL, true);
 
@@ -347,8 +347,10 @@ int fjes_hw_init(struct fjes_hw *hw)
 	hw->max_epid = fjes_hw_get_max_epid(hw);
 	hw->my_epid = fjes_hw_get_my_epid(hw);
 
-	if ((hw->max_epid == 0) || (hw->my_epid >= hw->max_epid))
-		return -ENXIO;
+	if ((hw->max_epid == 0) || (hw->my_epid >= hw->max_epid)) {
+		ret = -ENXIO;
+		goto err_iounmap;
+	}
 
 	ret = fjes_hw_setup(hw);
 
@@ -356,6 +358,10 @@ int fjes_hw_init(struct fjes_hw *hw)
 	hw->hw_info.trace_size = FJES_DEBUG_BUFFER_SIZE;
 
 	return ret;
+
+err_iounmap:
+	fjes_hw_iounmap(hw);
+	return ret;
 }
 
 void fjes_hw_exit(struct fjes_hw *hw)

-- 
pw-bot: changes-requested

