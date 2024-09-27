Return-Path: <stable+bounces-77900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D104988370
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 13:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6670A1F2265C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244917ADF0;
	Fri, 27 Sep 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HyuCsri1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14069134B6
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727437521; cv=none; b=IBNQ5ebaBkYOX2Een20Jtad1J+dQcxhHH5CyKfpM9/RZ1fEuYyiMhOKxIT5GNclj6O+vyg7DLbudkRRXu3XsI5D1f3kE10F8qxjSL++8LXpDynY9b0/Fadja70PZwuY2G4CyXfiB3UNbbR/C32sZkOTGrxCPybuw2MOAEXXqFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727437521; c=relaxed/simple;
	bh=SCBHUHxhOwHyz3EI7691IIa2jeVDdt/x341S4Aze9Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlyfNRgZWOQcEloQWjyUSH4XiAEhZxedHUOO7GbSbyKVM7CERyQv6pzqzSbMoq8Ot5RdyibPX+RKWdI0BWHE4XcRXFDykFXTkFRuv6H9vrRFfxfMgbku/cmLmNGeK+vnn/HzSXBaoGq+b1xwSK44/kSojnVnTxTN65NmYhG86xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HyuCsri1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5C9C4CEC4;
	Fri, 27 Sep 2024 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727437520;
	bh=SCBHUHxhOwHyz3EI7691IIa2jeVDdt/x341S4Aze9Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyuCsri15Qa9MOPHBw6bUyOaa7NNgvMqZgVUWDC0ETt2sHgk20D93bwiMx2tBHIXH
	 7zdo6BUcn0ejOllZPfnAv0kc8cDcEj8wZjXL8rG8q/o3/fdr9y36CqYs2GzKpHZchR
	 E0C73baS1s5RL2RJ3MxL0ihM8Uz5tvqOX+IfoDBY=
Date: Fri, 27 Sep 2024 13:45:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huang Xiaojia <huangxiaojia2@huawei.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
	linux-graphics-maintainer@vmware.com, sroland@vmware.com,
	thellstrom@vmware.com, syeh@vmware.com, yuehaibing@huawei.com,
	weiyongjun1@huawei.com, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10] drm/vmwgfx: Remove rcu locks from user resources
Message-ID: <2024092751-sloppy-pyromania-d2b3@gregkh>
References: <20240921064804.2868105-1-huangxiaojia2@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921064804.2868105-1-huangxiaojia2@huawei.com>

On Sat, Sep 21, 2024 at 02:48:04PM +0800, Huang Xiaojia wrote:
> [ Upstream commit a309c7194e8a2f8bd4539b9449917913f6c2cd50 ]

We can't take this until you submit backports for newer kernels also.
Please send for all affected kernels, thanks.

greg k-h

