Return-Path: <stable+bounces-98240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC99E33DD
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 08:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D311B26AE1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DE1E522;
	Wed,  4 Dec 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mEQLXj7h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BE18A931
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296170; cv=none; b=Be8QnAzLzQuOm9SfakiXXmBVJf9ywTmnbIgag3+MjV88StYAF1BRr75aJRyJpN17ibhBxJBYGDnS3iE92hpC+Foc+qnoVxXGLlH6l6LoczpO94D7emAwZfpJFCFdo06S2eli2nhtVxA4OhqvdKFQzcAUbg1vD1Gx0gJuPOoTgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296170; c=relaxed/simple;
	bh=ERrUTeJgGDm6rEh+szqITpNO+iN7LDdVTN0znQbfoy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4pzflKhrmBw43hnVWv4DHLAkDbJoddt65W+3nY4xemWhO3//li3H2RfN7RLDPIbfVgEXFBD9aNJnpCtcUHzGCp7zwHmUbwpo6165UZRovlUzsaqNQ58oNjWddFii4vS1ttMBXNRZvwHI4rJdv//gI6Hb3SL620GUYnVSARcuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mEQLXj7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C523C4CED6;
	Wed,  4 Dec 2024 07:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733296169;
	bh=ERrUTeJgGDm6rEh+szqITpNO+iN7LDdVTN0znQbfoy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEQLXj7hgSlwasZoxUkw7XxpBDx0Hr0nKlZcqSxUnyqkARmiacGmfwt8xrmdQ3Jcm
	 xhsM6+0WNrO/HIfn/NYAwCFIN+2+BNHU+iICSrQhhPVpOCDv5zkqXaAXCW40Bvx9dt
	 U3KJUHTdwhHsho94wrB3qOP7bQqxXHNvEWjfI9JI=
Date: Wed, 4 Dec 2024 08:08:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Yu, Mingli" <mingli.yu@windriver.com>
Cc: mingli.yu@eng.windriver.com, stable@vger.kernel.org,
	xialonglong@kylinos.cn
Subject: Re: [PATCH v2 5.15] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Message-ID: <2024120426-draw-aeration-99e3@gregkh>
References: <20241128084730.430060-1-mingli.yu@eng.windriver.com>
 <2024120226-motion-dole-53a4@gregkh>
 <09b31a23-62df-4448-ba2a-fd09ebdd916f@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b31a23-62df-4448-ba2a-fd09ebdd916f@windriver.com>

On Wed, Dec 04, 2024 at 10:07:46AM +0800, Yu, Mingli wrote:
> Hi Greg,
> 
> Sorry for confusion!
> 
> Please use v2 instead as we correct the author in v2.

Please submit a correct version 3 like I asked, this is long gone from
my review queue.  Also, please do not top-post.

thanks,

greg k-h

