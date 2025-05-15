Return-Path: <stable+bounces-144524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAEAB8664
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32804C0E73
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D176372;
	Thu, 15 May 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kry93nno"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8414B1E70
	for <stable@vger.kernel.org>; Thu, 15 May 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312347; cv=none; b=oS63CQ8MewSUj0itjH52Z4TeUEe6NjLyvGKPbVCyllVluBq/ePkfWYyOnu9EbmayxyB1SFTFoLME2msAy+EQMk9HKeLtvlKzNUEpqrU14NgEDFXY9fOh9E8z+ZgsFTmZUeOQDiArfJWxa4eqnA9CLmIufvOEyBSGHw+jMFRnME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312347; c=relaxed/simple;
	bh=mXtV/p3tpIeC0QGepjYirCNduEcmDED53SaEZc2lIx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU3mdX6yG5g8UCUpOs+fDrNaymNhqeCzu7CnJ93fifZPtpEFDt9lpAExRXW86n4MnRYQKZetPAyWwMFvr9pm/l2aa+3k8VgisXAL21Ta4ITCW6I9ThejVGP6xePBUZuFK3WrNuuSppsWeApKwwYtqE7KuW1AUf0FUV5mYal0d1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kry93nno; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a0b6773f8dso626789f8f.1
        for <stable@vger.kernel.org>; Thu, 15 May 2025 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747312343; x=1747917143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DHCqe2ELkkc+UlPf3xD1LiX/49qcNMEoSzXRssIhGY=;
        b=Kry93nno4cNjegdD1Ah0R1ebJSyCgJWauQI/4MQD0177MAnoQlb2T6LW0L9487q5Sh
         0sYDPrIn/o8w5FB3/GNkuCXdWEGkqnJoRcPEHQ5NXXnclZegmHhYlHs06iG0jN3DV/Ay
         QGc5g7DMYUqub/Q7pTWHjyLYCOpeJ0+7oDtEyA9p9cO1ViiDCr7Q3rdhjT3dzWs21vAK
         95FLgETC+MzslgF+Si47HFu8f5zXeML72y2qhWYk4pLnEiBAvNJ8m/zVhkfDEkoElHI2
         LZ/xWSgaY7n2dVeg6FebRJLyxsOI0L+QnaAbvBnAUesb+ck6jAsP//6oqaOWSXLVe5eI
         AKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747312343; x=1747917143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DHCqe2ELkkc+UlPf3xD1LiX/49qcNMEoSzXRssIhGY=;
        b=rXdbfx4JfsC6AjF33kfxM5bC6cE8/KQY8negWFbDOWSRi6sF6FRlvMoi/rqw2lS18A
         ZwuUAUSmjfmaTuim+sCaQH4TwvUZyj/mrEi6ja9PWBENjn//YuvhpMQvwa0jW1F8ogM6
         ADvtlbCn+a552bbc6oBQ0lpzGW0NIPmyXVssaM7uH9QyHZS7RtLLRuKvbf4QUNbluA/w
         /UP+2W9FGNzO1F6l8aaFS+lsxjdTCO6R9QIF4t9sNIj+4DWi6lLjtqHd10EFGMFWDeOT
         vCca4W5MahyAJhzLeGs0toNVXXKSAUFFhyZ6eaQnXT3U4JuOKbGlI4QPJLKUxNkA96Rn
         huqg==
X-Gm-Message-State: AOJu0YybjR+ZmtbkceMa8lD3xgchg7EoI1X4kKbpIJi6HIbtwM4DjPhi
	4djsQXauGLCnNflTPeqrtLMvTNfxWJAAeiQ7OAFedZbrg+BS261QBLMuYm++Srg=
X-Gm-Gg: ASbGncvNw+nb9GsPLvTirV8ylyAu+LlgPyD0bhemG8hAC65apuNZFEr9TOM/LDTos8a
	DSKSexMe0h47tp+U6924I2M8mb50TQrctAL/UNA8hKUOihZQ1BNb6X2l0bw5SIkugI/pUF+7f3w
	QsU/vQp8G1GSJ8vT+ioJCIIflcwGDNt1DpW3BQHu2jaJCbZ8hq7ISUjeUC2mQKil5l2Rm61F1Ns
	9kmcDkkcNT6zu8qBgGJjPgfh+dHraqhOiYgivHf3X3oBj0l/7FoBr+qIfXmND20SlBt5cSSc4Nw
	7LTu8QkJT4tISmKr8XEuLcO6YfVhOuFFWyJ/DUWj7JS89kUA1cFQ0fsyT/D3082mzCJHWWA2kTo
	NUvzkPPxSTg==
X-Google-Smtp-Source: AGHT+IHsBfMKfF7WyoADO+426AhNanVPeH/8DogvNYGecOtbesvKzwVwHUFljsLKdXD2rqKBnqJh+g==
X-Received: by 2002:a05:6000:250d:b0:39e:cc5e:147 with SMTP id ffacd0b85a97d-3a34994ef3dmr6026464f8f.55.1747312343270;
        Thu, 15 May 2025 05:32:23 -0700 (PDT)
Received: from u94a (1-174-3-124.dynamic-ip.hinet.net. [1.174.3.124])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4dfa297ee11sm195636137.12.2025.05.15.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:32:22 -0700 (PDT)
Date: Thu, 15 May 2025 20:32:08 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, kees@kernel.org
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc2 review
Message-ID: <2rlf4aoqeekjwcupepf6zkdkthhfwneeobiqeb3ujyz7ami5zb@eg5litfe4a7n>
References: <20250514125625.496402993@linuxfoundation.org>
 <vrvefaimjqkseuoyuhgg6omt2ypgp5v6xwwuxihj2t5jidizyr@ir5w67k4kl36>
 <2025051529-mulled-cubicle-b1cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025051529-mulled-cubicle-b1cd@gregkh>

On Thu, May 15, 2025 at 02:25:50PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 15, 2025 at 08:15:32PM +0800, Shung-Hsi Yu wrote:
> > On Wed, May 14, 2025 at 03:04:16PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.14.7 release.
> > > There are 197 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > ...
> > > Kees Cook <kees@kernel.org>
> > >     mm: vmalloc: support more granular vrealloc() sizing
> > 
> > The above is causing a slow down in BPF verifier[1]. Assuming BPF
> > selftests are somewhat representing of real world BPF programs, the slow
> > down would be around 2x on average, but for an unrealistic worth-case it
> > could go as high as 40x[2].
> > 
> > 1: https://lore.kernel.org/stable/20250515041659.smhllyarxdwp7cav@desk/
> > 2: https://lore.kernel.org/stable/g4fpslyse2s6hnprgkbp23ykxn67q5wabbkpivuc3rro5bivo4@sj2o3nd5vwwm/
> 
> Is this slowdown also in 6.15-rc right now?

Yes

> If so, let's work on fixing
> it there first.

Okay, will send out a regression report shortly.

Shung-Hsi

> thanks,
> 
> greg k-h

