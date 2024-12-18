Return-Path: <stable+bounces-105105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077049F5D4B
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 04:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC78F18889A5
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 03:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD80413D638;
	Wed, 18 Dec 2024 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="QWGqWVgu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452F84D29
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491595; cv=none; b=EwrnlmumiGjZsG/saPAq3VX+yiztTGq9M3uESrP/CNXmugQJ+TcVhtm8pKAOzhStvSLCDxz/TUQPLT4tR/xh5WjhIxRwC5ReMcH3pF2UVlKy7vYzS63r7n2DYG8TMBmFU9DgvyjZoPjXTniaobRDwWMO+UtNEKw/X+VhiEsUxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491595; c=relaxed/simple;
	bh=TSdAmdCKfkhu0fpTCtWuEzvsCUea3/N804lQ5srpBhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJTyRWmwVrDm71Pf/R/FuFsdrTWNHw/HJFNzBk9GQuT1LqWn/IKCW2hiKIFgvo/Sq/wv5u4XK3hCE8uBCZ61J7KeeqpzpnpKv+wG5/wCk5VdilSuQB8c3m7RtVxpqLyAzcLgWqdh/6lWrsIikxSudhPiL1LIZ2ntWpwnax9VdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=QWGqWVgu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4679d366adeso3158681cf.1
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 19:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1734491593; x=1735096393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRiadgdSYdBpoMNgXmugT9VcPJ4bnKgS6fG9A+Hj4xg=;
        b=QWGqWVguKh/SX3miGXNMlNKnL3PwEjmTfTGq6QOw9dHrW0gMoOVOe/dyVa+grtv+iC
         /0OEq9QiC3SUED5w4eW1wpMXEXc2P64sFGx9rFG+rg6V5ojR5ZT3phCJFd3oE1yZDd2j
         ZznpKf+w9nDE2iYNivJtmHrWHrvyVKUBToieQXGl4p5ZXe3zlIMVaQGgt2zJ2g3VWdEg
         teJCXfH7HLLhLoHpufbdGpC+q9tnyTwEdYBfnXY1FlJrXqD8Sv08ixKGyj5LuMAUBOa9
         phcZuzT011PpqJPMX+QOkTayfNFt7653zNgkJomOuWLQ5WT7EDg22bEDNhHyakLhKmes
         CBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491593; x=1735096393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRiadgdSYdBpoMNgXmugT9VcPJ4bnKgS6fG9A+Hj4xg=;
        b=bu0dDsYNxgelO2adTWHFRMvyWQXQbYsmDg1bZqZyEdDy5BQ/GukDc5GBKnNeOG0FPs
         9RAx6e5JRBkAWUPM5/q0OEaBItYkwud9w3Gql7mgLGUA871nUWw+k96U4zrS4YlTN0VD
         wuHBsJQqqt0cw4f+m8MrX87YoJg4hHYvB4NWEc3WCMyN6Q0bk0NDiVb9H94oGXVep9ut
         VeyKxZKko01Du5+vQVpYBuZJOLLmh7cv5agDNDdpSkVZNy6MBj2/FkF9NxPQ65JClhBy
         tIg+gMKuC6B6J/8JOsAJFVm4zuIKvxInH1y0gm9T97bQ/fU/UeJnj/qdueVFRM1xoB4Z
         WyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo4sKWzcxRg669ELZpRIHMt46JmzPsfZRfKKN1zHjEWzmrIJ5+zeQ25qOOu1HwrBFdgEaYeEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkCPETyFb2Bscsh6O6iCyiBwDGU6GT/mCITs1v3dLXgoyJNJi
	u5webTqoF3w0nqbKdfNbl1l9nlaPK8TCCgMG7cGsS0JosnZLHZREqDjD7IVKDg==
X-Gm-Gg: ASbGncttgkX4Kb6dLmEnlJdf1+PS0nEq16V2bR4a71wFIrPiL+13UsXI/irN2W/x06E
	v5lBYcF67k00DoC24VAwkrWzDW6giygsfLUtekOm5Cr0gDD2yIVXWwMupBcNl7sl7uXEysTCgZU
	utYZ/HA+Q4O5m1O/+ZR7Kv765TTpPR1j7nfCsNLzRWh0n+B0bqZ3dZDmMJ4GUB66xFvqUjZDT+x
	MH5i0cyrE3JFRnmIgd4Nk7S/tWat+bchcwi7Fjh/TZSo4CpctQ8K1KFTw==
X-Google-Smtp-Source: AGHT+IHmwTLyLNTi02LOS5ooyvlOWkFoWhx9Po/GonMxFiR2j94KBJQ4C5DdDpV1GZLL+bdJ7isQSQ==
X-Received: by 2002:a05:622a:94:b0:466:8f43:4aa8 with SMTP id d75a77b69052e-468f8d02089mr74975511cf.7.1734491592896;
        Tue, 17 Dec 2024 19:13:12 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::41cb])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047f3f5dsm382828085a.66.2024.12.17.19.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:13:11 -0800 (PST)
Date: Tue, 17 Dec 2024 22:13:08 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Ma Ke <make_ruc2021@163.com>
Cc: gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
	stanley_chang@realtek.com, mka@chromium.org, oneukum@suse.com,
	quic_ugoswami@quicinc.com, javier.carrasco@wolfvision.net,
	kay.sievers@vrfy.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: fix reference leak in usb_new_device()
Message-ID: <2aae349c-dd80-44da-9715-a214f6946b75@rowland.harvard.edu>
References: <20241218021940.2967550-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218021940.2967550-1-make_ruc2021@163.com>

On Wed, Dec 18, 2024 at 10:19:40AM +0800, Ma Ke wrote:
> When device_add(&udev->dev) failed, calling put_device() to explicitly
> release udev->dev. And the routine which calls usb_new_device() does
> not call put_device() when an error occurs.

That is wrong.

usb_new_device() is called by hub_port_connect().  The code does:

			status = usb_new_device(udev);
			...

		if (status)
			goto loop_disable;
		...

loop_disable:
		hub_port_disable(hub, port1, 1);
loop:
		usb_ep0_reinit(udev);
		release_devnum(udev);
		hub_free_dev(udev);
		if (retry_locked) {
			mutex_unlock(hcd->address0_mutex);
			usb_unlock_port(port_dev);
		}
		usb_put_dev(udev);

And usb_put_dev() is defined in usb.c as:

void usb_put_dev(struct usb_device *dev)
{
	if (dev)
		put_device(&dev->dev);
}

So you see, if usb_new_device() returns a nonzero value then 
put_device() _is_ called.

>  As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.

You are correct that if device_add() succeeds and a later call fails, 
then usb_new_device() does not properly call device_del().  Please 
rewrite your patch to fix only that problem.

Alan Stern

