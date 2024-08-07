Return-Path: <stable+bounces-65962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347A94B173
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA551F21D32
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3DB84A51;
	Wed,  7 Aug 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB3EltZk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6581411DF;
	Wed,  7 Aug 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062916; cv=none; b=FbahFDMblaDQALMX1wHrVx/73u9rBjYMEroR91WD0tW+pjn3UQW1iqUwpzkWO8JD1tgyUFMO0m0wcH+0dusS+KEahoEGoMl9+Yr6heeqRbRJoDHyoXY4HCvyWRpU9LY0XD8TH3hpesvZXvPYkG1ihRi5O/oYaUyQS/O14uO1CfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062916; c=relaxed/simple;
	bh=qBbWL/E7dVwm/+E2BMlbjiTzO0J3JlgIgKy7sLixUfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxXB+fWXptjZj2+kk9yd0c/iiRfWDoYgj7fjuJ+L65nlHcZZiAMS5lLkpBv6fzv9RuGtT/pd8Hlw8oBwg6lZVK6hrw9mT1gitEtDKsBwsb/22dyXCPE4Ut+z3VPQvyHcOaGJDDCa2Dsvrw0pBBoK4EdSF6RKkuSQa3onDntOpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB3EltZk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368440b073bso159312f8f.0;
        Wed, 07 Aug 2024 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723062913; x=1723667713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNxGrrfKIhfJF4Io8gZIBAgwnq2hHF0xRbZogrcKOpI=;
        b=hB3EltZk+WF6BtVfOG7irvtE9Ar6cga+ANMdBooteKh2rEHABXwMtIX1p+rqj4eZTJ
         Vpvczg2hP7u7JHrdlJ2JLQdjsvQBQx+Atb8QaJHTxLrZvkofB5jnbAmu/Y/WWeFIWPsX
         Wlj/SZTivH4oje4hdZyUl6UNVnB5niFylb/4Ovm88ccatxma61ZOIE4VbWhHUEqfHLV+
         YrEzwiaaZrhyI+rMMmZyONqILLLmc/3y1tNkz0jLnjA+APe/f+qq429D7+vUCRH9YoIH
         IifeNmWuCyR7l5U+lXbTI7KttL1dZZDGk0dQcRU6n1KfxmMZyv2qSMFV94T6egTSrTyO
         YTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723062913; x=1723667713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNxGrrfKIhfJF4Io8gZIBAgwnq2hHF0xRbZogrcKOpI=;
        b=QdmC9iz1BE2JF4kfCPVupsiis873QzOQym6JfCSC34RsiFChlg2EUbomc5ErPVPh7e
         3ZRrEXR9XXR5LtxlIixD8Sd8yfDte9tHF2LFdng+KP3RqpEgNNsXT0y9pFCXfju1gMGR
         lBm6GcPNziw/UzQ3EffSH6u8vHMYWZq9iPi/GViUbJoCikcf0rH2tWTRTgcOT1fK5Afs
         evdRPHMkYupnUxmG8xukcy57QX077tj0ZyH+SRYxT9q25Oprnl+dL5DAT/n2Y0440aPS
         DJll/o1Zs54mvzMo2aYyJRvYD6rgpPyH/NyggfsYDaS8rlyZ4WctJVg24Rz3rQeINlv6
         gBoA==
X-Forwarded-Encrypted: i=1; AJvYcCXCwZlAaRSyBLM712/HvdzQnmK6G3tlslxHHpkOjxWNKLoH0gk/g+SBwJ9TrH3XUC0UDKhCSaW9t/cI2RhcBOJFTxe1fNf3EL5Lev/G
X-Gm-Message-State: AOJu0YxSj1F87VZ7TWQeFTC8G91u6IwpN8sfoboiQQ2DC1QWX4aLIIPK
	ijdLOpKM5qTYrge57cmiNFDmspNanruFINfH2SkFk7cAlND50LmB
X-Google-Smtp-Source: AGHT+IGcPA1L+NIrYOGJiS0c9GwB7dYI5msYuSnJXjCW+syfUwF8BTHYfKMjXvwQRrEJNb8b0j50FA==
X-Received: by 2002:a5d:6483:0:b0:367:938f:550 with SMTP id ffacd0b85a97d-36bf0f6e472mr3441387f8f.25.1723062913094;
        Wed, 07 Aug 2024 13:35:13 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01ede3sm17096780f8f.47.2024.08.07.13.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:35:12 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 7D5C3BE2DE0; Wed, 07 Aug 2024 22:35:11 +0200 (CEST)
Date: Wed, 7 Aug 2024 22:35:11 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Akemi Yagi <toracat@elrepo.org>,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
Message-ID: <ZrPafx6KUuhZZsci@eldamar.lan>
References: <20240807150039.247123516@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>

Hi Greg,

On Wed, Aug 07, 2024 at 04:59:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Aug 2024 15:00:24 +0000.
> Anything received after that time might be too late.

6.1.103 had the regression of bpftool not building, due to a missing
backport:

https://lore.kernel.org/stable/v8lqgl$15bq$1@ciao.gmane.io/

The problem is that da5f8fd1f0d3 ("bpftool: Mount bpffs when pinmaps
path not under the bpffs") was backported to 6.1.103 but there is no
defintion of create_and_mount_bpffs_dir(). 

it was suggested to revert the commit completely.

Regards,
Salvatore

