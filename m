Return-Path: <stable+bounces-3227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332AF7FF1BE
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E327E281BB6
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63E4A9AE;
	Thu, 30 Nov 2023 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LmGuU3mS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3C38DE3
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9844AC433C8;
	Thu, 30 Nov 2023 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701354419;
	bh=jQGkj2wDug6g7FNZ9iqJPEbamLlNYDGBrnxOlztW6h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmGuU3mSuGan83XWMIiqLjzYqQmrenBeJPTVgqLPY/m8QcMchJcjxiUIXfOYMJgLQ
	 kyk6AazmDWfcbwYq4d+GytJSNpGe3ljzmKeqytuoJcxP7ixpbLs8RGVf/TfLOVKbOH
	 0B1PfE0MDDJw3SQQZ8hhavmEhFinv8TH+U5XN1mg=
Date: Thu, 30 Nov 2023 14:26:56 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5YWz5paH5rab?= <guanwentao@uniontech.com>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	hildawu <hildawu@realtek.com>
Subject: Re: [Re V2]:Patch "Bluetooth: btusb: Add 0bda:b85b for Fn-Link
 RTL8852BE" has been added to the 5.10-stable tree
Message-ID: <2023113024-huff-cushy-3b6b@gregkh>
References: <20231124043548.86153-1-sashal@kernel.org>
 <tencent_27789A681229CCB77BE3E186@qq.com>
 <tencent_13CC3606408C86A21D09FB05@qq.com>
 <2023112442-glitzy-rocking-4a8a@gregkh>
 <tencent_429FA9BD3B6671BC788386A6@qq.com>
 <2023113015-justifier-nastiness-3c66@gregkh>
 <tencent_7B1A767250D25DDD0AA40C93@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_7B1A767250D25DDD0AA40C93@qq.com>

On Thu, Nov 30, 2023 at 10:17:16PM +0800, 关文涛 wrote:
> > Can you provide just a list of git ids, without footnotes or links, as
> > that is a pain to attempt to cut-paste from?
> Sure,
> 
> v5.15 git id list:
> 18e8055c88142d8f6e23ebdc38c126ec37844e5d
> 8b1d66b50437b65ef109f32270bd936ca5437a83
> 
> v5.10 git id list:
> 0d484db60fc0c5f8848939a61004c6fa01fad61a
> 18e8055c88142d8f6e23ebdc38c126ec37844e5d
> 8b1d66b50437b65ef109f32270bd936ca5437a83
> 
> v5.4 git id list:
> 0d484db60fc0c5f8848939a61004c6fa01fad61a
> 18e8055c88142d8f6e23ebdc38c126ec37844e5d
> 8b1d66b50437b65ef109f32270bd936ca5437a83

These do not apply cleanly to those kernel trees, can you please provide
a working set of backported patches that are fixed up and tested for
these branches?

thanks,

greg k-h

