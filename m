Return-Path: <stable+bounces-204960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA32CF60E4
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC3B63062E1B
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBDFBA3D;
	Tue,  6 Jan 2026 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcBEECdo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E033EC;
	Tue,  6 Jan 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767657901; cv=none; b=FQClq0XE4Zr1n9OBE+2RJLBXxYxz+CfL74nWA55aRivp1cXC2wSoqQK8v69VtwaWQykdq9j9PI+22mjo2XtI3itmor45RYm90cAEe8fBNsoC36ustLt6SS0rG6iEn0RLmJh2000Z33Q2RYENZ6c6fuPl5pNOQANoHIOHiPFoIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767657901; c=relaxed/simple;
	bh=B74BagB6SCV2x9DBpJXHJyqf1LRlBLte5qZJstFZsM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thHw+z3sFAM5yeh7/bv5yZl9a5UcNPPQaQyeIBt4UEpo5fBzTAMKXfMmmFJGApPPCIJv/4Y1XtTnOuP4LaqsR27Tjf4o6pthaWgr0zskKRw/fScm1WvQRMXR1/eWHZGFDynCTAwSZqotm6KwbCwiHq4VsfO5Gl3tZrCykGuZWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcBEECdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3475C116D0;
	Tue,  6 Jan 2026 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767657900;
	bh=B74BagB6SCV2x9DBpJXHJyqf1LRlBLte5qZJstFZsM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gcBEECdoxj8ODTbaJ2qu1nbuadk/uIqYhNLS0oqiMFBW6prPRNmdV6PrzdzXK48Wp
	 OvYz3JBwB3M8fA3oH+x0Ju2tjtSZhC/uR/o6kLlGP0PUz8i7DIM9FIU5VTYlgk6qQs
	 c6vSz6WWrKgznS62DloZRkqneXEVcXfCZ4PMCy47s+7k+UPWKyY13hKd3NS2Ezbg3X
	 +uTjEwM3OVjauzBx/L6Zne/mqwhmbvWadbAhU8XIG6akzCIYOhRrP7l5YDlT0A7SRv
	 A9FtLAkyHdOCL8mpEFZp5l9GLRay0zxOKSiV6aHCmjwVspfKTwjjKVvV3BRlLV/QyJ
	 ajmKwcTJUM8pA==
Date: Mon, 5 Jan 2026 16:04:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in
 bnxt_ptp_enable during error cleanup
Message-ID: <20260105160458.5483a5ea@kernel.org>
In-Reply-To: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 Jan 2026 04:00:16 -0800 Breno Leitao wrote:
>  init_err_pci_clean:
>  	bnxt_hwrm_func_drv_unrgtr(bp);
> +	bnxt_ptp_clear(bp);
> +	kfree(bp->ptp_cfg);
>  	bnxt_free_hwrm_resources(bp);
>  	bnxt_hwmon_uninit(bp);
>  	bnxt_ethtool_free(bp);
> -	bnxt_ptp_clear(bp);
> -	kfree(bp->ptp_cfg);
>  	bp->ptp_cfg = NULL;

Is there a reason to leave clearing of the pointer behind?
I don't see it mentioned in the commit msg..
Checking previous discussion it sounds like Pavan asked for the
clearing to also be moved.

>  	kfree(bp->fw_health);
>  	bp->fw_health = NULL;

