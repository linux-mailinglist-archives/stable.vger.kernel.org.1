Return-Path: <stable+bounces-119873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC7A48C83
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 00:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E99C3AEF24
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 23:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF62288EE;
	Thu, 27 Feb 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HClOBCHP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F83C1F;
	Thu, 27 Feb 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698121; cv=none; b=ouoTOBR2DqEwtIvqGQOJ5IAOZagE/IOyyltd7QrqHcsXOf4XglPlcetgJiJQI1JfFdljL9mJE9a6fL6kOT3dbp6C72zWN8gOqPJH4OyVIC2/FeNX9IN4XzfpTaMSxo90T3eQzX3SwjRmEkQ21mMiyALYwW8+bmn8aVVdLIY/Y4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698121; c=relaxed/simple;
	bh=GZ0IxKXhs5l6xoXe9cqSWDPLEe5+lFTovORNZ21/kXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TMDSc729N5ooDVZPcoJCeAGwv+7fKAneUem574YDv/whURKFRgURqlS/7gLp/r/nBLFqMh5ErykVw7K3yWfwFdDoLSzVUfGNxoLeWqh3KKZex7LFtXI0AEaR8nlX23a9zpfoiTOjJ988uNg5mtvxZmnECF8YwfFudQvk+V+aaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HClOBCHP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so16710525e9.0;
        Thu, 27 Feb 2025 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740698118; x=1741302918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upHKPxofYs7grxb7NMPS91d4+y/mUbTVdMGymIHFZrw=;
        b=HClOBCHPZrVy1F9VRFFf5mifS82Cl8/fXkl89eYlDZPaxDyEIfyCo2Fk5TL78aI/tS
         z+pBa9iEyac9c71LH424V8jLDcytdGIlt/rU/gwijAYsAvx6IMdY+05l+zc9hCA+0SME
         7N+46kwMaycMG2x+J3T4B6ng7cdT9x7iUCkgIyW3DVaE4vhWu+ven0GCGM4p8+HlPF2G
         KvYn81MtJyBG12KksB3Xt7Bkd1VoSUK3WfGQ9rNlxz3Ib3wkwqP2qkBzynW8uTnOf+md
         S5f/CyUO5V08hyZU/jVZocaWLiRLWDx6/Fna+kTN8w+Xnt5WQzIXeKxja9Pm1gfFTzfA
         Z3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698118; x=1741302918;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upHKPxofYs7grxb7NMPS91d4+y/mUbTVdMGymIHFZrw=;
        b=XBrxuCpItEbv8UKgglfPGk1FuoA5tq8eVeM4/O2w2TLUh0ZYJCEUM9TaktstEpnvG/
         64y0CZN84Vsmmk24sjBxt0fKxVIx5FouKGCJFuYt0uzEnsbKmdLhJ0ho4s3CTkshovd2
         pY+ZxKxz216RHLZMcNxLqb/Mc/zUahgO1cNlMT0KLvJZyiKllVxCbejf0Sv49ocbSj90
         AsmC5p0iVn4oRolGd+4hgVQk+JyBn9DG15Iso75vV+4BXdW0pQwAISQAyCW8UOqu/OpS
         Fl8qRHOfUTssHqWd9+k+cJ/EClvaYwqeqE5qOrRQ68jM9fPrhuqJQf++s5g227Jev844
         gC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEmRpou+RtUkApBY5Hflj91yEed+p6rN3CPG8iaJxyoRgpW3gE0cxew/mZEJesxMod3PXiqxBwNmWS@vger.kernel.org, AJvYcCWarEp9TLgVbFEIkFafBYumfY/zXloysnK3R18o1d92kRO+6/P1VdGMEHK+iaQx6BLUf8phizl9@vger.kernel.org, AJvYcCX9mYAIQa7DPOxTEcoOHY+GSdhhlF21W172eyMPh8i8Y2+wYWVQt8PqAfVSdH0fjrnWvYjumX6y@vger.kernel.org, AJvYcCXVauBBhgwrHuA33dgV5C7t3KJj1ihJ5qpxuSSwfMtWcCPB17tQ9zDMk2klKFsIMjPKjVBO4w5xVCs5MWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrrkoE+CyW0EhkHDYiyqjMdEDOhAcScvVKIv5iJAL6xI6SgxL
	4oaiRf3pEZ72blHQKcdsETV5yUMYxIKe90WJb5tTeN3RNBa9CHh+
X-Gm-Gg: ASbGncuq3gbaOBAGtE+t+pzGnmXYdIZyHOZkzdUO3lqRYWL7jAi961XFKWp1pzCgDeQ
	vl1YtnpByVGdIL20udmRnMIhpL6f5K694o/hkQRWnl7oerBmS+3HF2AWrma5rsNu57AqABP7Y3Y
	vV6RPydZudL27IHUhDJsZF3JmgrG2t63KKVE2MdZg0LzHq3uChls4OsGqvJkJnbwUcJeg3l/U5H
	TvsyGhLpyPc4OL1nuKVd/t4FEwkpZIoVSRzsMF/cbFklhVAdps3c6Pd8VCMVQrmBehSC2I7SKXS
	wFOhYZhtyU5/w6p7r100Wu3KzBNqYA==
X-Google-Smtp-Source: AGHT+IGUAfAPDhOU2ooDtM65n6XBa2TpX2XimIfiqy6zMSSrRmSGwbZEuWMWPQDFdM+s5D7sbB27iQ==
X-Received: by 2002:a05:600c:3546:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43afdda633bmr43534885e9.4.1740698117724;
        Thu, 27 Feb 2025 15:15:17 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:79cb:51f4:38ef:97dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27aa85sm36558415e9.28.2025.02.27.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:15:17 -0800 (PST)
Date: Thu, 27 Feb 2025 23:15:04 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart()
Message-ID: <Z8Dx-Jh71VIc4fzm@qasdev.system>
Reply-To: 418ddcf6-e7c9-4a8e-ba1a-38a83cb2b5f8@lunn.ch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 26, 2025 at 02:43:31PM +0100, Andrew Lunn wrote:
> On Tue, Feb 18, 2025 at 12:19:57PM +0000, Qasim Ijaz wrote:
> > On Tue, Feb 18, 2025 at 02:10:08AM +0100, Andrew Lunn wrote:
> > > On Tue, Feb 18, 2025 at 12:24:43AM +0000, Qasim Ijaz wrote:
> > > > In mii_nway_restart() during the line:
> > > > 
> > > > 	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > > > 
> > > > The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> > > > 
> > > > ch9200_mdio_read() utilises a local buffer, which is initialised 
> > > > with control_read():
> > > > 
> > > > 	unsigned char buff[2];
> > > > 	
> > > > However buff is conditionally initialised inside control_read():
> > > > 
> > > > 	if (err == size) {
> > > > 		memcpy(data, buf, size);
> > > > 	}
> > > > 
> > > > If the condition of "err == size" is not met, then buff remains 
> > > > uninitialised. Once this happens the uninitialised buff is accessed 
> > > > and returned during ch9200_mdio_read():
> > > > 
> > > > 	return (buff[0] | buff[1] << 8);
> > > > 	
> > > > The problem stems from the fact that ch9200_mdio_read() ignores the
> > > > return value of control_read(), leading to uinit-access of buff.
> > > > 
> > > > To fix this we should check the return value of control_read()
> > > > and return early on error.
> > > 
> > > What about get_mac_address()?
> > > 
> > > If you find a bug, it is a good idea to look around and see if there
> > > are any more instances of the same bug. I could be wrong, but it seems
> > > like get_mac_address() suffers from the same problem?
> > 
> > Thank you for the feedback Andrew. I checked get_mac_address() before
> > sending this patch and to me it looks like it does check the return value of
> > control_read(). It accumulates the return value of each control_read() call into 
> > rd_mac_len and then checks if it not equal to what is expected (ETH_ALEN which is 6),
> > I believe each call should return 2.
> 
> It is unlikely a real device could trigger an issue, but a USB Rubber
> Ducky might be able to. So the question is, are you interested in
> protecting against malicious devices, or just making a static analyser
> happy? Feel free to submit the patch as is.
> 
Hi Andrew,

How about an approach similar to the patch for ch9200_mdio_read(), where we immediately check the return value of 
each control_read() call in get_mac_address(), and if one fails we stop and return an error right away? 
That would ensure we don’t continue if an earlier call fails.

Let me know if you’d like me to submit a patch v2 if this sounds good.

Thanks, 
Qasim

> 	Andrew
> 

