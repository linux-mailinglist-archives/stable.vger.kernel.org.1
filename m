Return-Path: <stable+bounces-139217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AADFFAA532D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F114C3537
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DFF26659C;
	Wed, 30 Apr 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+X3Tdj8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BA1C173C;
	Wed, 30 Apr 2025 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035867; cv=none; b=op90X2hrFIQFzXu7+FVGIFOI6WlmYmcMG/97wKe6t405ozX2jqDOQqUwGim9coJ6ChasldB7RUoIdutYgMjobXOVFMFYmgPqVdEg+FsKK/ZJLByHKnjdWx7ses2zW6PADOCSAd3cxFRgkDK+gnTBhcZ7gYjM6e0fHtAGKzAOKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035867; c=relaxed/simple;
	bh=SajprH2K30LIydhzXkAMsM58eECJcqMGzV1nbrQLJqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qA9wtCgA0Yw4/ruoQIdDK57v8lxFqfA3+wzxIkWcFKuY8lSEjNHB6ueEVRDTeDarWDzBQAkQC6PuOYaw+bkGQZGEX8p9+p0zsqOi5WvKhq2g+uOzZFHfaUkOgx4c7wV0Lx37+6sP40MauG+1vTCLJdtmAqssr6btdYulBYmgcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+X3Tdj8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so1194875e9.1;
        Wed, 30 Apr 2025 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746035863; x=1746640663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knwkLP8bZlOU4Ot1owL8Zuv0fy61zzZy1KJe8/D0OyI=;
        b=Z+X3Tdj8ZtyBp02TotbGA5qEsMutK88qx1wWIyBjKwuhC4v9OS8RRa1u9KSumbFlAU
         QjwSSRkFaTmsOkyajxnolIio+VEY57wSmEWOs9+QV32W6vvS+Bw+JzP25EETYWpD5Pen
         XEGDaIgVntWRGI3fHNTXWRVwYBYFXHP5JysyrIfqcCqTIuHUoVKNCRQgnKTZxhBCpvLD
         ILK5COBXbqIdR4nNycqDwOtRWybEMh+tfoRiB4TbiqyuhAK+4DvJXoYivK8LguW8Gzzm
         daIpe5n6QY+cHjH6m5fYZMkPdMzBXjvw+OP7JUtyIuFHQylTc7zJF2X2PTPgE92DwgeJ
         rTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035863; x=1746640663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knwkLP8bZlOU4Ot1owL8Zuv0fy61zzZy1KJe8/D0OyI=;
        b=Jcw05qu1o1LJcBzwdIKp2p1h3BwytXR3K1lH6Wg170VyvFNne949iNNps4KqVcOQik
         9db+NHlpAe43wm1UsuYnCo9sW3imBYZmayN9aiuO1XAz9rCAUtquSAJMfOom8ZvDHrIy
         yhd8jss5HF2UnwCFnMfezBgRnZXReJCHLdTo18m+pooqpVa51CCcv/taw6LsOhKLnaSX
         kmufpt1ONZu9x6HpmbK8mjmkEPegZPW+cQ9Xo2TPZDzWQ+5tIHcgMlDGT7f8hZZs9izC
         yzXQ53LCAuz5E7cuSBCmAbh24oprx0/ZCzf4O5SYrMI6TGpmeguMMgCgJ1JMKEoMHhTv
         T67A==
X-Forwarded-Encrypted: i=1; AJvYcCURnUWva1s1NYTe8SQliHFgf9S5nmzT37nF5HJPKuYgl/Cq1Z98VbNrixGuAmxC7YPib0ucj+wSUVau@vger.kernel.org, AJvYcCV/D5qh1n95GoURzWF13A8u5XnZfYhohnk+Kh/gJaTrY+jPegUe/w5vYpP3x3LRMFDqSIDMuISIYpCDK08=@vger.kernel.org, AJvYcCVXYwSO9sFg+n8XdNZ3RGhdKMQTAke2GN/HzIplFoBaJqJfRBJRto0v3lSlf9QW+LNy1Vrlg93x@vger.kernel.org, AJvYcCWKdcZkQVCkD/rP/ksAcLxz7GCiJ2JoQHwkZalRb9UopwV2ZRPO382Io0DddS7ez6e3f4vW+IIT@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfc/oAa0SBdSUs6PhTIqPK6iY5xJwAPlw/PxpeEAM6F8aZSb3
	HSgCRKkE4cRqpJWhzNvjxu14yrtsBMpMWUqnCJnxqz/v8EeDHOsD
X-Gm-Gg: ASbGncvGjstA+B5qXt+AWcdtZJH0JKk3tdz7v5z7AWSEaXxVysh14fPXKZNKcI0uV+H
	/mZGEuX/C3gHwLlmuxB9vX8RARL726Om8MgoTIquZ2zv57vE+wIDu3AYxH5L/UqfGQAynkMvTgA
	X/gYw+77bD6xg2lfp7u5g75jGswKC4HlESNDDRAqjyi2FyND5yBBcFLOwkUcp7iohIcCW/EQDdj
	hym0ksfQxw/lEboVUVE5yqRU59u+fFC5TWNz6ru+5MNEQDSmlgfJA5DrYqEabaoRqVB6QTDlcfN
	m0kchzUl7C60veFNvgimJ9O10RLzIvG0pXb1JE0=
X-Google-Smtp-Source: AGHT+IGHNL860r9eXW2UPi9Dvf6qMVbcDrVTUOnwIVHAaIYXX/pj5/TigUadekaluxWYvKoApmG7QQ==
X-Received: by 2002:a05:600c:46c8:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-441b5c1a29bmr4075625e9.0.1746035862479;
        Wed, 30 Apr 2025 10:57:42 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:7d1e:a9b9:e7a2:cc4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b20c3fsm32274945e9.28.2025.04.30.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 10:57:42 -0700 (PDT)
Date: Wed, 30 Apr 2025 18:57:27 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <aBJkh5q_W1xVuv4U@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
 <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
 <20250415205230.01f56679@kernel.org>
 <20250415205648.4aa937c9@kernel.org>
 <aAD-RDUdJaL_sIqQ@gmail.com>
 <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>
 <aAtgOLMnsmuukU42@gmail.com>
 <3a84b8a8-f295-472c-8c3f-0655ff53f5cc@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a84b8a8-f295-472c-8c3f-0655ff53f5cc@lunn.ch>

On Mon, Apr 28, 2025 at 04:22:59PM +0200, Andrew Lunn wrote:
> On Fri, Apr 25, 2025 at 11:13:12AM +0100, Qasim Ijaz wrote:
> > Hi Andrew, Jakub
> > 
> > Just pinging on my last message. Any thoughts on how to proceed with
> > this patch series, I left my thoughts in the previous message.
> 
> I would suggest you do the minimum, low risk changes. Don't be driven
> to fix all the syzbot warnings just to make syzbot quiet. What really
> matters is you don't break the driver for users. syzbot is secondary.
> 

Right, got it so avoid breaking it at all costs, in that case should we move
forward with the syzbot fix and the "remove extraneous return that
prevents error propagation" patches only? 

For the syzbot one we will return a negative on control read failure,
as the function already does that when encountering an invalid phy_id.

As for the "remove extraneous return that prevents error 
propagation" change it seems like a simple low risk change 
from what I can tell (if not please let me know).

Would you guys be happy with this?

Thanks
Qasim
> 	Andrew

