Return-Path: <stable+bounces-40733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D718AF42C
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0962287CE0
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D55A3217;
	Tue, 23 Apr 2024 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLeD6Eb0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74F1E485
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889944; cv=none; b=rcUlFzgFciIFe9vjEY6UFywbN+zuju5cUQxM4Q/aZjWzuYcEK8qguxBhvQtBp20OUvwO5BpFUcE3P18dVXqB+szgOBL0YoUwIIJH6J6laT7IpUFbzl7asn/o6dgcyf55PJHWR3xs+N3y7PgzATX5498feA6fFsgPwSXG42gmF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889944; c=relaxed/simple;
	bh=w+KNgWrPEVs8x9tMDC6NYUvGz7wLZowPidUQjzR5xZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VODhG+r4fVmsCNt2JKkwj3YyzooE94GUgW1OXOzv6X2Zymgcjas0wt6kC0eqzbwujJbUbR7/Ln/mI4EEUz6oelQLppSCjrDg7maXk2Ci8ZI794xnAxSI4/U1b+LIn74fjg81v2P+cF0PbEge/VA+OKDxoXMaquu7oo6ykHd2AmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLeD6Eb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913F8C2BD10;
	Tue, 23 Apr 2024 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713889943;
	bh=w+KNgWrPEVs8x9tMDC6NYUvGz7wLZowPidUQjzR5xZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLeD6Eb0+pGQCPeOMPlbsgot8vG1fnXf4bcvZjLmcFkAs7tK05urfaSYDEuYlO+jX
	 i2X6mifMoUsruwLLtcmBI9nonuI0qlsMcVIJJv4j980Ei67Zu6dImpcFuXiU09TDLp
	 BgUV3/moUuUAWDGqubULNvw22aUygEoVaoxyJA3I=
Date: Tue, 23 Apr 2024 09:32:14 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	qemu-devel@nongnu.org, Heng Qi <hengqi@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 6.6.y] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <2024042301-hankering-staunch-7363@gregkh>
References: <2024041412-subduing-brewing-cd04@gregkh>
 <20240422151803.1266071-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422151803.1266071-1-vlad.wing@gmail.com>

On Mon, Apr 22, 2024 at 08:18:03AM -0700, Vlad Poenaru wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 upstream.
> 

Now queued up, thanks.

greg k-h

