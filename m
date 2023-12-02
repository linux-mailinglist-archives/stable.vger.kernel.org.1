Return-Path: <stable+bounces-3697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20225801B2C
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B74281DD0
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0BBE60;
	Sat,  2 Dec 2023 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWWfHsZd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5AF567C
	for <stable@vger.kernel.org>; Sat,  2 Dec 2023 07:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8AEC433C7;
	Sat,  2 Dec 2023 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701503165;
	bh=wzNB0cmd3aXZGRnP87p4TN+Ap7H7KSknl7BjShRoRcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yWWfHsZdA4rl12cN2jLvbYt6FyKcbwoljeq3ct1f5HufZTURuh8/m3xAue4S5AnoC
	 IFxS5FGUttjqgsY0bpbKGcvnCh447r35jlj7t99PPu+h9WYXtn8Pzl3/pcfb8FTAfU
	 zxp74asu72poJezj88823QADBhIoiJIbDehJlAD8=
Date: Sat, 2 Dec 2023 08:46:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid tracing a few functions executed in stop
 machine
Message-ID: <2023120231-poker-napped-be47@gregkh>
References: <2023112431-matching-imperfect-1b76@gregkh>
 <20231202065616.710903-1-debug.penguin32@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202065616.710903-1-debug.penguin32@gmail.com>

On Sat, Dec 02, 2023 at 04:56:16PM +1000, Ronald Monthero wrote:
> 
> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>

You lost the signed-off-by and didn't cc: everyone on the original
commit, how come?

thanks,

greg k-h

