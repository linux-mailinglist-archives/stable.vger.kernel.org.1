Return-Path: <stable+bounces-144763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB40ABBA75
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D432D3B3DB0
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF326B2BE;
	Mon, 19 May 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi+D/wP+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5AB1C700D;
	Mon, 19 May 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648728; cv=none; b=Ebwpqr3aCBV6zu2BWYow83Dk8xZ2TYS/sf1QG2RAfWVGG4RMATYM+HZnxuEooahN8zDH4raVjVGWqUM7EgJ1ucacoluy+FRSXZ5hkAFJcFCG8Cn6EXxFkIZNUKJTZLlgesNMh29ly9GsZjHJzn1sbqkAwXzXXEf7szJX34rbC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648728; c=relaxed/simple;
	bh=BULzTI+kU/yFHjuWDARlx7VCTVOizir1A/u8XhiRkzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dm4IhKsuQEkKzdHc02/JboDISpAIYn7jWwdulVAr7rlxa2rSnQ/LlcL/Gi0mjzrIWBIgjzyEVN1AvUmdLXq5TTay4qNX7gUvqynTW/Vn7Cs4LLirXIioClpcY+BiCRE5448gPw0Kt97KLdFlqBPnA934dyU3L2y3sQQRE/bSJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi+D/wP+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a361b8a664so2797978f8f.3;
        Mon, 19 May 2025 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747648725; x=1748253525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYyBcaz8kCnB/KqkOCAJ3EoGTN4+avpwMpqHG0vlynU=;
        b=Wi+D/wP+7/mVsCMmFJN5Uen7SPauM/j7yWoXzvDLU7vntxxzUcwPh2LZ9WKySd2+Jp
         4a8qHCgOpZjHxY4FbB9LxK7HTe9uH/ofY8ZTMMgFDb/fuNk9+8j27bVOEV7XyMR4d1pd
         XQRd8FpivRp/Wn+Mug3JcMwd+3ZmJkhG71XxxmGc0sj11zeCnD4rZbJqPNWcSR7VEqPL
         jPDEDv24mk+Dh1ooWydGH/aA0e+7qvGLc6QrcCCsK8n5iGPDbti1cKw67p7/Z+7XVbyZ
         3xE0rWNwSnqPI+ujHD0GQBgnQZqL1PI6unxhWU82roGQyOqMPfoPueEOrMJTPNi3qgqq
         k0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747648725; x=1748253525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYyBcaz8kCnB/KqkOCAJ3EoGTN4+avpwMpqHG0vlynU=;
        b=vyHqwT4s1SK6GGc8j79bTFsa9omrWV27LluC9sVGe2DIp2mwLJbflmKDaTuVYiVa17
         I9EweHeEIyqtehPNK0xVwbuy2+V6RaTrpPTUr6XXOgmkWcfa4tcyELbPlKTJRup158ut
         8HBLyuBoVwFBL3Cv4ssBtTu+6K+Lq+TakPWffEn9ybcG309Re2GZj/pky3m+FBVM82Cx
         cD3dpow/ayokrcrVDCDJOvFBPC6YtT9Me7RYMhc9Nt8SQq/xUIhv9X5yOzpMD2sXC0b+
         kiIYZTTKXTFaA272WX2hbml4ro0npTP0drjh2tcjVrNmArzqy5WIVtVHBw6aIDp0IZdN
         te8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKh3BVrhn9vuBgO/DXYhynS9VZKufzdO9JzJ+IZboZ18B7UalkUmRNSeAgpP9GCE1plzuwrEirhFPu@vger.kernel.org, AJvYcCUWfHb+qSZCZaIyRoOQI+qm+H2kJD5EZ+VQwvbWaGHGuru6tykkouWTSolf0AZSP/Cu/3RZWNrsqwAe+A0=@vger.kernel.org, AJvYcCWOvNUNeoEHSVjkeMGvQizlXkn2tjfz8Cp8GkEvgQZ2UOdDXvr19DuUpHwwTvw7deqwVVQn+rWV@vger.kernel.org, AJvYcCWxWWiI2404gnpy7GJB3G1waqkpRHtBqXbZcinpj5BeBl2WG8Pty/Ts0muHZydRMJh/Mun+wFJW@vger.kernel.org
X-Gm-Message-State: AOJu0YwhY2/feyadz59hhGa0GI6KUWWvG/0pZgv8ks2u6sy4RjvgWUh1
	tEfsFT3YSAeNlmzuWMW31qTcPobB7LD4oHZnnVOZhl8jZtW1415v9i/Z
X-Gm-Gg: ASbGncu4VIU328yEKQ3dPM6zBfJzSprNvViylYX/l/QvdAtXZJo8i7mRFVCvag04vcp
	Jqg2bZcUbdzzn1Yp0lih6tgJlHyOE+1j/5UuYNIx3Kfp7e3tTMvSftD/VGrZz9m9E8h9GaGSWgt
	5Pfvz6NyA/G9YgxyyXF4z4gs9ab+h9yTw3PszKCZkEuWV7hjmABG/Yk0heWp8zXi3jPfmRnWH8+
	+bx93vT3G0+IYCW51TwjGMxwGbP+D4c4pfZtfjn9vcgMF3HpSzWMfiG6Ef2sIUrgfGfV53kHNnd
	0nWXYY2MjqYAc11clIeJS1hClo6K7tp6XWfC7qgCRfWPhL8oOK8PS0CoX2wI
X-Google-Smtp-Source: AGHT+IEjy99fUf0yop/vxJ1GvkuSu8tPy7j7ikqwQLaUnjNCFqXwZTNcBGIzyrdUnnK3P8HBbZM+bQ==
X-Received: by 2002:a5d:5f8d:0:b0:3a3:5614:38e9 with SMTP id ffacd0b85a97d-3a35c808b1cmr11411928f8f.10.1747648725085;
        Mon, 19 May 2025 02:58:45 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:12ab:e3b9:2247:b915])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62961sm12027515f8f.49.2025.05.19.02.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:58:44 -0700 (PDT)
Date: Mon, 19 May 2025 10:58:42 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <aCsAxtrVzcCaseR3@gmail.com>
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

Hi Andrew

Just pinging on my last message, how should we move forward with this
patch series?

Thanks
Qasim

> 
> 	Andrew

