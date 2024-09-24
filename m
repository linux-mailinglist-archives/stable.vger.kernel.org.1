Return-Path: <stable+bounces-76964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2A98407F
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2B328228C
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717714E2CC;
	Tue, 24 Sep 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="blPpYqWO"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E31487FE;
	Tue, 24 Sep 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166557; cv=none; b=KuDJlsLfkf4FN/X6avhAZykHBLn+depfZtQCZj+IsfWygNY8cidR2YSJDlLUz819z2EAWCMmAnDhez6xGvV79DkFLPMr8IxW/bNRgN/Zaf1oBKju0v/gjSPkiZFy6M+KEoexS9bppr1gYSfbLPEwrueWHhG/ywDatdXpnd2zwMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166557; c=relaxed/simple;
	bh=GRau/PauUlLiN0C2MQ5TA2UVSsvpxY+3t9kYPn8Vf+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sC6YykNrzk7KcBkKLCsa7grs0xh9yTywYXeoNYVvTB18r6iF9ABGwOiC3KIpM2YRQOM4rZhbBIh/2N+JvYBljbCNHcmKcEnlESOmzM69vwnhuFcoGCy+e9ANt2xyTQk6ADDiEGsO+ekeYzWp+xXr3aqLxVqAcehclMYC3MDnyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=blPpYqWO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UirR61iMoW4GwIsFJUrkfbWojVybY3oTt7WlY3uQK2k=; b=blPpYqWOvDBZ8LqGXL2vP9ch9r
	1BnD4yJ04zgxPC4jLUs7rdFkW2ZRHlSOaQ5dVngwdqLZKDfvs/TK02Re5vzlqXEV70t/tPgf0r/zf
	+KjQ2FraD1OgaWnUYFYxac5iRSFuuwM6pmYsdfxgvHFFLvQmNXl2eKOaJP7meWbnqlLvZCQSZot2J
	oCwdkN8AoXmFvJQ+LueRK2zw8IMT6IcWcrrIgPRtq7VGR2N50XmGqoYAwQgkhBezgfu6x9lDuTmbH
	ryIE3t4rItrnqvNm8NpOTvdOXn49fVxrj+dxMVlM2IxWSEadu/6m80JnBSCo5BYHaWGaBhtanDFQr
	n+MsE6DA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1st0us-00056x-1B;
	Tue, 24 Sep 2024 09:29:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1st0un-0006EQ-0h;
	Tue, 24 Sep 2024 09:28:57 +0100
Date: Tue, 24 Sep 2024 09:28:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: pcs: xpcs: fix the wrong register that was
 written back
Message-ID: <ZvJ4SSqPpYQ8s0r6@shell.armlinux.org.uk>
References: <20240924022857.865422-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924022857.865422-1-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 24, 2024 at 10:28:57AM +0800, Jiawen Wu wrote:
> The value is read from the register TXGBE_RX_GEN_CTL3, and it should be
> written back to TXGBE_RX_GEN_CTL3 when it changes some fields.
> 
> Cc: stable@vger.kernel.org

Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

> Fixes: f629acc6f210 ("net: pcs: xpcs: support to switch mode for Wangxun NICs")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

