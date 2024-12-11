Return-Path: <stable+bounces-100549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC19EC6B1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5598D282889
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B52F1CBE8C;
	Wed, 11 Dec 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgRPAVEK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BB42A95
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904848; cv=none; b=hus7SFIbyOEq9ToFA5Pe+gaXaJltGSxS6uyEd3P83c1JNhLGgq54IkGo3oVOSLNgRhkFGx7WYlD7f72uvVnOd3TuLv36XOdV0MyZbk7Jlt6fjhoJcx2X/5QZJY3zYFtyaOv+fJ56C8090j71mdU5xYSFzMVnM6BWT8dHSRu71fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904848; c=relaxed/simple;
	bh=i7AbN/UdS47zctoq+vz8oR92G7WXSYmHs9wn52nl68Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiO2KgBF0Qh9BYVG6uXYYzYgBthX0TRpkHK94LzF6R1TNyIRxlx6n3pYIymE2rdxbvOEyWFtsFU6tSumUC07Xgh3YnKZNz/J+ZvA7NrvxFdaYH9SpSUpbZ3cdnrV1VTkTFkTCvk9J7xE/IM+hnTiLMCFKYjfgi9DvdgWyGXZi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgRPAVEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D761C4CED2;
	Wed, 11 Dec 2024 08:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904847;
	bh=i7AbN/UdS47zctoq+vz8oR92G7WXSYmHs9wn52nl68Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgRPAVEKQTMCneSfGbuMCLUFe7ePhWd8clOuwsfSUvuGIRzpNlvY4nAkxD2nzoxab
	 UQmXiCcc/YYDg2kDxY/EcaU4O7HeNWm7cUNRgz4rtMt+nbzpW0AjHyuoLajj4UwdOd
	 n6/MgT/tM0tIykf/kzDDJEz1aIv7ushN7oskV5Lw=
Date: Wed, 11 Dec 2024 09:13:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org, irui.wang@mediatek.com
Subject: Re: [PATCH 6.1 v2] media: mediatek: vcodec: Handle invalid decoder
 vsi
Message-ID: <2024121126-halves-ancient-2d17@gregkh>
References: <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>

On Sat, Dec 07, 2024 at 07:20:42PM +0800, bin.lan.cn@eng.windriver.com wrote:
> From: Irui Wang <irui.wang@mediatek.com>
> 
> [ Upstream commit 59d438f8e02ca641c58d77e1feffa000ff809e9f ]

Please cc: all relevant people on backports.

