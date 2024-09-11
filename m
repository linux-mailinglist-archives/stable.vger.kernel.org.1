Return-Path: <stable+bounces-75791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C333974A08
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 08:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148032865D7
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61A762EF;
	Wed, 11 Sep 2024 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="J1b8b/GJ"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0C537E9;
	Wed, 11 Sep 2024 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034402; cv=none; b=JLxn4F/M/rMuMagXWS8gVH4qnWxec5DPCYjaE5KwxOrwkW4bjApGKneaoL7DISd/wzzhXcffwpe0/ig5uVdNSYntwoj6xFFKKVQzbrFi2YIc6fJBD6KNqBPkcuCZrhrZxE20/wMFZG2KQvzk5QSfTSKQAakIfxBMygz5/+frrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034402; c=relaxed/simple;
	bh=7lreXfc1ipzLP797BDbOKztY164sv8ZHRn0PO8soXGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsA8DJlFr3wXT1iRDIEz9kg67PuHHgoimZaQlvdW+XW6MmC9h4IkpCX0Crdm1kbVYVzzZ44a3A4XDCpZYN2c6jhYxihk7BPPBxza8HfudeXIZUHvjnyn2CNgBfZeg7jrdUUrmbcQnF3H86uMFDLdzTTdj10P0hb++4sBf9tH0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=J1b8b/GJ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726034384; x=1726639184; i=deller@gmx.de;
	bh=3b82UITyOxmOM9vRItxI3DHJ73eMoLwBC3BgV5yPcEQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J1b8b/GJcCJ4w6TmIrYj0pK/2hP7dJgWnBRF8iSPYe5y/IH8Sz+7V5ZlEnnTDclj
	 +NojcrFVSirUg0FVe3hP+PguDyKEJADUwiZ4ynI6IaWNoVdn9FnB0Hz0am3Jc/aiD
	 0rjh9m0HeJObMj+6nr1nax7QJNSACGMdvj/XqSthOy4ZaVKgLXVxXP/nvJGx6xVnj
	 bhYWfgG3B765dacoWAmJN+1do8VaN+SsFU5Yi5tegR9atq0HE+uo3c9QqwXiqqMRh
	 qCJ6T37LUx39gQVKPuzufbN61cgg5C6EeGXPwNNnnUjxxK41598aVS69iGezf/PhY
	 i8Jr6OxCRYEE75CGqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1sJJDd2qqv-00lnZY; Wed, 11
 Sep 2024 07:59:44 +0200
Message-ID: <69952d52-3c3a-44a0-9288-38b0383d3379@gmx.de>
Date: Wed, 11 Sep 2024 07:59:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/xen-fbfront: Assign fb_info->device
To: Jason Andryuk <jandryuk@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: xen-devel@lists.xenproject.org, Jason Andryuk <jason.andryuk@amd.com>,
 Arthur Borsboom <arthurborsboom@gmail.com>, stable@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240910020919.5757-1-jandryuk@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240910020919.5757-1-jandryuk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QmWTlB3DIIbT/yRTL83FJmTRimqUTjlC8ZTCwCcF5dueJqx7tck
 cwZp0lQMgxnoO3nMtjgHB/JTIpjLAEee+BdSNtbcp9zbFmoHWxkDbcw8ON87lVYgUpfPhwo
 zAzhj5grj2A0n8Tdw5Mf08Fr+dobF04H2OFST/pJfMEOFhVnKa7ix5poAbr29A02/00GZvp
 vCLSWsWLSy301nZKLrt9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K1nZCGCwO5w=;SfG1kgmeWqjZabSHXkfS8oByMkK
 SgBE5zPnZeylPa4GYh4SmQroEe400qeY8J8SyVwR6f84W5YUXUD5ufpiHFSNGvAybshgzKBMu
 KGcltUiOVvNVUVo9zkRzHLRezShpBZl5Xtma0PPZE3eOCEe6iuA0m8Vhu+dtQPXnWnumXh96e
 hWmWomAHpMEvvlIuUc5oSnyjbFU5Akj15QED+uVkdOoVJRKnwvyGZbpf8iqRDFlBxoylT89bY
 3WHawluxFHOs1Wbk9Z/IMzwf0J1FICKKke1osNhE1RBzRZvquzOWqf6wJtOxwtIMmx4Nr21AD
 4gGqxr6iyst83jDP0Ol6B1EuHeL05kaKHEbVInulf4ALGnp5JzGwaAT5ZwNG00GQqHn5FmbVp
 H7I7MEDhdXHf23koQSfwXMC/S1FsyNR9W1nkyiMYuurdWNiwYOIzTkto6tZTpqzXq4qD56CCP
 OYcQtebsv6id9XUoHM29uqW4qUbUYzosFkmDqYAwqHecFN43wUQ8jaJ4lVyBFz+MCbnEVK5cU
 8NaVsrZZKiEFYx/j5Z+xRdNKeTppzdGYCFZXzAopc9jlZDgpZzoXyaaaMTQOsczfii0YVpPKV
 XsSJeB/72oVx8N3PFK8V9HWYfPaY6amw+D768IoiQZ6Hcl6ZNNOgNAkiLdrUaggBmyW5C/duT
 nBkrXT712ZLfOiJKL/IwEnNymYj2JGr1LAAWS/qt7Idl9Fic1FBIo4EFsLHYC12gFZIE58g8/
 /t1WHT6BVTqupynV0WIwDGyryA0dcGAvMRuUoyG/Snvi1q/wUICjY6RLtgZM++6G186ufzlxK
 KR4n5FQK1oQK4eJ4R0MOJthw==

On 9/10/24 04:09, Jason Andryuk wrote:
> From: Jason Andryuk <jason.andryuk@amd.com>
>
> Probing xen-fbfront faults in video_is_primary_device().  The passed-in
> struct device is NULL since xen-fbfront doesn't assign it and the
> memory is kzalloc()-ed.  Assign fb_info->device to avoid this.
>
> This was exposed by the conversion of fb_is_primary_device() to
> video_is_primary_device() which dropped a NULL check for struct device.
>
> Fixes: f178e96de7f0 ("arch: Remove struct fb_info from video helpers")
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Closes: https://lore.kernel.org/xen-devel/CALUcmUncX=3DLkXWeiSiTKsDY-cOe=
8QksWhFvcCneOKfrKd0ZajA@mail.gmail.com/
> Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>

applied to fbdev git tree.

Thanks!
Helge


