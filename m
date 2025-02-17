Return-Path: <stable+bounces-116595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16509A3870B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 15:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E9A3A4FB0
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3804D2236F6;
	Mon, 17 Feb 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="cM89GE2q"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186E22257C
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804148; cv=none; b=IvMDlgUnvxz3uWL6FMgIn8z9FPEa8Cvim8LAGQVsHLvFTW6oyGoKsNBJt7Z8hI+WfqIigljNvGu4Ub+deZLgowRdjRcj+gQOil9uptdBJzaFG+i/J6uBAXhPUV9QQVYLkglrW8V41beescB8k1TfDTaXPvvP5xW+DGBmIeOMW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804148; c=relaxed/simple;
	bh=cda0iUrha4/OfoRLCstTRgJh+1Yzv8SfT1RHe8MAAr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUXLlCTaySIwwLjuZ7TjUa2QfLs1iuASwYjlEPiLgnPw929KRHmyPfTquCOUb8KExNkf90rlemi8MDwBXYcKqQbMB9+vg2olpRcd2G4r5ETRWRBR6WIMqfRmlIctOU8uT3nAHIX9g09FqcwUAAGy4P0BrYiescOL0UA2vZDX5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=cM89GE2q; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd1962a75bso30668316d6.3
        for <stable@vger.kernel.org>; Mon, 17 Feb 2025 06:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1739804145; x=1740408945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=61zWE6kfcjwEOh5eZ6HUP/yfQ2wvTQwtRwwsjzC2Ggw=;
        b=cM89GE2qQeLQWKv57Tk3jzH730jVhvnvlSdwoeAIr0LkIcNWZ1EntqnVfPmulk4lth
         crkD5AwuOm/H+WsdW7fvkzgPFbHCPPaDFRT2Od29EOqy94Gf60IgU/czvttUmbUW7BbA
         /o/Lv4mW9dGacqU4GqV5hjnbJHyxASuJV9boQwIXGwtaoGFJcVIxquIK0VA1fb+h2UxV
         ZAD7lZu0lnkuehPyVGH21uu9RH2+tqiAdCzUGrT/bBlx8QFCvJLJ3f3Xa6yMlulLHp57
         VdyyxBTHN72+SM4wFMinvLd1Ks8MpW08/D15Rjg+GgWpdyTotPyY9Myrzu6BZVQwscqN
         7/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804145; x=1740408945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61zWE6kfcjwEOh5eZ6HUP/yfQ2wvTQwtRwwsjzC2Ggw=;
        b=VKB5bPe04lhCJ+W/w0vIL3DuQT0C3IRgIPlYNNHb/IVhCt8CPYPaEmj9eoBU6EqXB/
         ZJ71JyQ5lHEPD1pHUek/j12ag4CEm9FBMrbmnOl2XCCYzY7nBz78JzU/Dgd8HqXbl8oC
         00fqQOVvesUJsaGIFlNNTCbxVvcY6DJfaPPxZ926dJ1X+2eYUMN74PbCwKaO6YlLjULr
         v7ObnAF7hdT46wLOoVf2cIu9l76dRphTm08fNgz3nd1uWyF28pYebMSjl099YKzKthW2
         Fv0W1WM8202rsS2bQs7daR5AiBO/BLM7ql7UMZvM8LdcvpTuh6AXIUymbvMwKllad22N
         YCpw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5aKfO6/U1q58SFzWfmPhnasPkDxDTOVhuEJKrCGrzwkLxeq93jwMaXA2Psr9P2b0T0YQeC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/CVvSTNHe/xiPA30k28RGKRAE4sSF0WMS9fs/9iIqWYkRyvl
	g2hrZbhdje+oRA6wkB7F0LfigYgOoFLYJOC4lfLRgt0IfSuYQ4l7gcZdZvCRHQ==
X-Gm-Gg: ASbGnctixh7q/O5LyxlIXVGSbQ7jbzO9rCVBFP1rVBZXCj+HMtS3miRYSxkK+KxTUaG
	FK+mWZ5MLpnZIbq5G6Bs4g/pm9c+KtwyMXaQxJA08yV0Tijh0XdSsGh6zGuxnneMAiImQNSlxpv
	7kc1rY2dutE1e6TGQjNKAxRhvzk8FPTQuEp5Oqar0tPyvsn/wYHVoaDh0heYXY/t/Jj4ZOH5C3n
	Nol/j25N1Icao9ktZKeBSpF5f19BCfP9b8/38dwebG2f1kx6NBvg6HihUWHcOUIJ8ivcV411ms+
	1IqEjTutDH1waQGO
X-Google-Smtp-Source: AGHT+IFERKSiWL+IE76LI0Jb/5d2nYVqmycpTQYeVY7DjUZwF5gEcJTAtEZcrH6lWANjZ9iaLtK2Mw==
X-Received: by 2002:ad4:5d4b:0:b0:6e6:6048:f42c with SMTP id 6a1803df08f44-6e66cc7fe50mr144532386d6.8.1739804145160;
        Mon, 17 Feb 2025 06:55:45 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::46b3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e67c868dd8sm14282976d6.79.2025.02.17.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:55:44 -0800 (PST)
Date: Mon, 17 Feb 2025 09:55:41 -0500
From: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci: lack of clearing xHC resources
Message-ID: <7ca4737a-aac6-4a14-8629-bd5404a6f902@rowland.harvard.edu>
References: <20250213101158.8153-1-pawell@cadence.com>
 <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <b39d468e-beb9-4a44-8fe6-83754ffbd367@rowland.harvard.edu>
 <PH7PR07MB95383C03E64507BED1D64222DDFB2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95383C03E64507BED1D64222DDFB2@PH7PR07MB9538.namprd07.prod.outlook.com>

On Mon, Feb 17, 2025 at 06:25:35AM +0000, Pawel Laszczak wrote:
> >> For this scenario during enumeration of USB LS/FS device the Cadence xHC
> >reports completion error code for xHCi commands because the devices was
> >not property disconnected and in result the xHC resources has not been
> >correct freed.
> >> XHCI specification doesn't mention that device can be reset in any order so,
> >we should not treat this issue as Cadence xHC controller bug.
> >> Similar as during disconnecting in this case the device should be cleared
> >starting form the last usb device in tree toward the root hub.
> >> To fix this issue usbcore driver should disconnect all USB devices connected
> >to hub which was reconnected while suspending.
> >
> >No, that's not right at all.  We do not want to disconnect these devices if
> >there's any way to avoid it.
> >
> >There must be another way to tell the host controller to release the devices'
> >resources.  Doesn't the usb_reset_and_verify_device() call do something like
> >that anyway?  After all, the situation should be very similar to what happens
> >when a device is simply reset.
> >
> >Alan Stern
> 
> 
> Yes, I had such idea too, but the current solution is simpler.
> I don't understand why in this case we can't do disconnect
> The hub connected to host was physically disconnected during suspend, so 
> It seems quite logic to make disconnection. 
> Can you comment why we should not make disconnection?

Imagine that there is a disk drive plugged into the hub, and the drive 
is mounted with various files open or being written when the system gets 
suspended.  While the system is asleep, the user unplugs the hub but 
then plugs it back in before the system resumes.

Under those circumstances, the user expects that the drive will remain 
mounted, the files will remain open, and there won't be any data 
corruption on the drive when the system starts running again.  But if we 
said that all the devices below the hub were disconnected then none of 
those things would happen and the user would lose data.

Note that the same sort of thing can happen on some systems even if the 
hub does not get unplugged, because these systems do not provide suspend 
power to their USB controllers.  In addition, the same sort of thing 
happens every time a system goes into S4 hibernation.  You wouldn't want 
to force all users to unmount their USB drives whenever they hibernate 
their systems, would you?

This is why we should avoid saying that devices were disconnected during 
suspend.

Alan Stern


