Return-Path: <stable+bounces-15595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E7839CA4
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C0DB2606F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 23:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471053E04;
	Tue, 23 Jan 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eB+dbyzQ"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7642DDB5;
	Tue, 23 Jan 2024 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050802; cv=none; b=QurVKzUWbU8qatWBH50Fe2EHMBA1ITo8J5+w+dlTCMDcAQLFFkeDg0Eg41Zcou6g+GE9CISi7HDsd3TqznE+3QOagVVUZr7BX+Nzoin7D3yGcl/mMG8BC3MUx+fILTYTHvdcmt7SSzep06P83YkP1PJOPfbEQ31ad6SHhaCFvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050802; c=relaxed/simple;
	bh=8xwlc7MGcqCvMRjkHOZubnZy5/7P87qpf0FVev832cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K51Zrpm+sz3hFIVQIAM+vhYdqTxO1k4QebxB8rRF6uoyvH2WCjG+oqWRK+m5iywN0xiuSH51LN5iVuIXaI9G49kS/v8fq9NgkhNGv3BKzT61Vy4tOMERA4hBaM5QVlQnZ/OELSw05H9RZKtq+np8R055PE6UI4afn9FH+bwc3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eB+dbyzQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p+okpn5rGPjYb8kKdD5Ih+F44qguZfi/1iKVDlb0xSo=; b=eB+dbyzQt+aQZ0ZIzJ4XZAHFEC
	JbMo0Beke50gs/spknsDN7GT1X1vBnYI3fjPFZB+j8twrEpuVdz5fKPVdcuwvAZdvAIcdMtGbXlQE
	u7Brxbjy491kA5LTOd4Caxu8uD0DrssDkxdPcTcX2GlhiMLUT2hdSDCZiGMz3yFg496Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rSPkB-005t0I-GU; Tue, 23 Jan 2024 23:59:47 +0100
Date: Tue, 23 Jan 2024 23:59:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Menninger <tmenninger@purestorage.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev-maintainers <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	netdev <netdev@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
Message-ID: <32d96dd3-7fbb-49e5-8b05-269eac1ac80d@lunn.ch>
References: <20240120192125.1340857-1-andrew@lunn.ch>
 <20240122122457.jt6xgvbiffhmmksr@skbuf>
 <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch>
 <CAO-L_45iCb+TFMSqZJex-mZKfopBXxR=KH5aV4Wfx5eF5_N_8Q@mail.gmail.com>
 <5f449e47-fc39-48c3-a784-77b808c31050@lunn.ch>
 <CAO-L_46Ltq0Ju_BO+rfvAbe7F=T6m0hZZKu9gzv7=bMV5n6naw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-L_46Ltq0Ju_BO+rfvAbe7F=T6m0hZZKu9gzv7=bMV5n6naw@mail.gmail.com>

> Does that mean if there's a device there but it doesn't support C45 (no
> phy_read_c45), it will now return ENODEV?

Yes, mv88e6xxx_mdio_read_c45() will return -ENODEV if
chip->info->ops->phy_read_c45 is NULL. That will cause the scan of
that address to immediately skip to the next address. This is old
behaviour for C22:

commit 02a6efcab675fe32815d824837784c3f42a7d892
Author: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date:   Tue Apr 24 18:09:04 2018 +0200

    net: phy: allow scanning busses with missing phys
    
    Some MDIO busses will error out when trying to read a phy address with no
    phy present at that address. In that case, probing the bus will fail
    because __mdiobus_register() is scanning the bus for all possible phys
    addresses.
    
    In case MII_PHYSID1 returns -EIO or -ENODEV, consider there is no phy at
    this address and set the phy ID to 0xffffffff which is then properly
    handled in get_phy_device().

And there are a few MDIO bus drivers which make use of this, e.g.

static int lan9303_phy_read(struct dsa_switch *ds, int phy, int regnum)
{
        struct lan9303 *chip = ds->priv;
        int phy_base = chip->phy_addr_base;

        if (phy == phy_base)
                return lan9303_virt_phy_reg_read(chip, regnum);
        if (phy > phy_base + 2)
                return -ENODEV;

        return chip->ops->phy_read(chip, phy, regnum);

This Ethernet switch supports only a number of PHY addresses, and
returns -ENODEV for the rest.

So its a legitimate way to say there is nothing here.

You suggestion of allowing ENOPSUPP for C45 would of fixed the
problem, but C22 and C45 would support different error codes, which i
don't like. Its better to be uniform.

	Andrew

