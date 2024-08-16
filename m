Return-Path: <stable+bounces-69289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E8F9541B5
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 08:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491F71F215E5
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 06:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6657E76F;
	Fri, 16 Aug 2024 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jgF5YHXh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654280045
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789719; cv=none; b=ABitx/WrWksw7BTlNzurmegohc8kwHCbOcvVwKV0zZyxxHzwd/qQnPNODCSdO7MiDaJGv7F/ZXshB/jIOqtiLMQGHI7k1i0Z/dK3Yh5mevG3QGT4r8ulhfSMSK6aZlVFS+3x7RWsoYa715NA9nlbX694Yc0CIFfznkxpOGzeiqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789719; c=relaxed/simple;
	bh=bVnL9mWO+xmONoQ2eXFIoAdzIAkO74CrAfNgWl/8wQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WA5SwspreZeGkmw7FHdRZ0Z8TYOQGFuYt1H2UYqHTZqQ1A/y9YiwjWcUWmKiZQ2DmxNaRLDpYGM6nHrXDt6O4WFaQElgIKqivPX8nAIZWKfIZ7GaDcf1otS5rlhRXqY4FgV8yk5GAMRrqp/QpO59mFrrvlIcj8QQeXcT36XWALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jgF5YHXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2408CC32782;
	Fri, 16 Aug 2024 06:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723789718;
	bh=bVnL9mWO+xmONoQ2eXFIoAdzIAkO74CrAfNgWl/8wQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgF5YHXhDG7xNu6YZUMR5XN0X5XI+S1s4/09D5fDM9woPI+sW2ISpjwlFRiapvU1S
	 ZJzo9xEd0rkXK+w07ZUPhkOOi48JBvS8W5VN7VZZOEmvdF2x0rSEoGLt7RjUQqPN8o
	 W5ixzsKFQHTCyTv+RRAG0tjLd8yask/L80FFodb8=
Date: Fri, 16 Aug 2024 08:28:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Manas Ghandat <ghandatmanas@gmail.com>
Subject: Re: [PATCH 6.2.y] jfs: define xtree root and page independently
Message-ID: <2024081652-oxidize-unreal-405b@gregkh>
References: <20240815183641.7875-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815183641.7875-1-sergio.collado@gmail.com>

On Thu, Aug 15, 2024 at 08:36:41PM +0200, Sergio González Collado wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> [ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]
> 
> In order to make array bounds checking sane, provide a separate
> definition of the in-inode xtree root and the external xtree page.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
> (cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>

You submitted this for a lot of kernel trees that are not supported at
all (i.e. end-of-life).  There's nothing we can do with those backports,
sorry.

You can always see the active kernel versions on the front page of
kernel.org.

thanks,

greg k-h

