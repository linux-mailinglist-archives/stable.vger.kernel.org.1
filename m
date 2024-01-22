Return-Path: <stable+bounces-12817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448FB83774A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771931C2513D
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930973771A;
	Mon, 22 Jan 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1SBPrx5E"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438431D683;
	Mon, 22 Jan 2024 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964528; cv=none; b=QwG+41zPitBqLCVLOg8rAUJDAPsDforD7EsilVTWP2deEsP5n0TdhM1SMgNfPXr4JD6V7J3THQpNpZ+CpvU5XYvc8qzt+N+3N/u7CT2LycT2jLcVk0FNPJOgqw/xBZKpu3irvzak6Tcq/mEXEAvj0VBEwmMnrdrDYKkd+mx8xPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964528; c=relaxed/simple;
	bh=msPH/QovNKRrRRB++PtjTpko5zkcFfMhC8VmQiE6/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjy2TH9pRH4r+TPhSQ7m68RYND2lUgTDgzT4UzEH7msA8HO9re9uQAoUOkC7ztXiDU4XJEZ7+JpiootglgvCB0aR8QdcJyM/cAKAOCsDS7znCizUMKyv9eC9IxgpEZ6ief1/ONUu3uPeluDutxppAqVi3o7U7RLhezC9jVJDmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1SBPrx5E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KRw78m3Bu0Lh0xEAaZeRhX3+itpQs8cnM41OSUQcl/A=; b=1SBPrx5EOt9aBHEAmrDPhz5nRv
	4Mx1v/L0bNRd04j6uwcKOcgKSJdziAptqz6IhFClnEmoN7JUuGntEnTl8n1DWEAADXkd5IlxA91Re
	6shIs0M9FrU9RAe4zHNF2tVFbaqYk6ErSYF9cHhnrOFo7iO9tW2uvsmXjlv4l8+hKOhw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rS3IZ-005mCa-9Z; Tue, 23 Jan 2024 00:01:47 +0100
Date: Tue, 23 Jan 2024 00:01:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Menninger <tmenninger@purestorage.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev-maintainers <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	netdev <netdev@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: dsa: mv88e6xxx: Make unsupported C45 reads
 return 0xffff
Message-ID: <5f449e47-fc39-48c3-a784-77b808c31050@lunn.ch>
References: <20240120192125.1340857-1-andrew@lunn.ch>
 <20240122122457.jt6xgvbiffhmmksr@skbuf>
 <0d9e0412-6ca3-407a-b2a1-b18ab4c20714@lunn.ch>
 <CAO-L_45iCb+TFMSqZJex-mZKfopBXxR=KH5aV4Wfx5eF5_N_8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-L_45iCb+TFMSqZJex-mZKfopBXxR=KH5aV4Wfx5eF5_N_8Q@mail.gmail.com>

> I'm not sure I fully agree with returning 0xffff here, and especially not
> for just one of the four functions (reads and writes, c22 and c45). If the
> end goal is to unify error handling, what if we keep the return values as
> they are, i.e. continue to return -EOPNOTSUPP, and then in get_phy_c22_id
> and get_phy_c45_ids on error we do something like:
> 
>     return (phy_reg == -EIO || phy_reg == -ENODEV || phy_reg == -EOPNOTSUPP)
>         ? -ENODEV : -EIO;

As i said to Vladimir, what i posted so far is just a minimal fix for
stable. After that, i have two patches for net-next, which are the
full, clean fix. And the first patch is similar to what you suggest:

+++ b/drivers/net/phy/phy_device.c
@@ -780,7 +780,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
  * and identifiers in @c45_ids.
  *
  * Returns zero on success, %-EIO on bus access error, or %-ENODEV if
- * the "devices in package" is invalid.
+ * the "devices in package" is invalid or no device responds.
  */
 static int get_phy_c45_ids(struct mii_bus *bus, int addr,
                           struct phy_c45_device_ids *c45_ids)
@@ -803,7 +803,10 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
                         */
                        ret = phy_c45_probe_present(bus, addr, i);
                        if (ret < 0)
-                               return -EIO;
+                               /* returning -ENODEV doesn't stop bus
+                                * scanning */
+                               return (phy_reg == -EIO ||
+                                       phy_reg == -ENODEV) ? -ENODEV : -EIO;
 
                        if (!ret)
                                continue;

This makes C22 and C45 handling of -ENODEV the same.

I then have another patch which changed mv88e6xxx to return -ENODEV.
I cannot post the net-next patches for merging until the net patch is
accepted and then merged into net-next.

  Andrew

