Return-Path: <stable+bounces-115135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3835A33FF1
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEED18886DA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913023F41E;
	Thu, 13 Feb 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NNLCppql"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9781A5AA;
	Thu, 13 Feb 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452135; cv=none; b=ogm0Bxy/02ncdIrzUGTv1ozk8k6iYMDRfJvbTWBYefImFk3X3ym/iiPC6GyiGpkdWxJnIPDTUT8l4v1FxPOYLrr9oUGZidLJ+vnGwogooKlb4u7oWl3KN+/MeUBN/rFj1v+BvSPsCTJklHAweQs6gUskhIykEVISxNVmsloosg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452135; c=relaxed/simple;
	bh=9s7MimE+YYoctk+mnufjjoHfb5s4zIIEoaK1K0eE10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8c8fyxdYRBcN50Iybwfu2jkaVKbQxJSNoQJXnLyGkv4OSjlrZFtAPiSG9hTe0mrmFCdr8IqN6KfjVZvTuG3TN2LTW977TFZ6kyxIlWCMjetxkBLb1HHt9DQbTJp4vZDAkSA18VRMf3+ZlNM1uNT0mtTF00IMToL7w9OZDt83CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NNLCppql; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M9/Oig8k2SAjxriJP00zkicDUzgrwHu+QT+BDfkghm8=; b=NNLCppqlXEu1bqbdg8rysui6Su
	UFiy1+HGCbGry+7stYjruvsQ+P5E7G0o4E8qI77Z/yfEnpRSeVpBrNLZp0AWLZloVjFAWRWvBDxPW
	wz/38krf9fAk67S/rBFdK6CBM4crfCOSPjHt4wnE+T09/W7WJ/d2k6N09pZhFBtBWX4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiYxB-00Dk4S-3x; Thu, 13 Feb 2025 14:08:29 +0100
Date: Thu, 13 Feb 2025 14:08:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: felix:  Add NULL check for outer_tagging_rule()
Message-ID: <a3b6a30d-2a9a-48f2-a6b5-bb6517f7e4e8@lunn.ch>
References: <20250213040754.1473-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213040754.1473-1-vulab@iscas.ac.cn>

On Thu, Feb 13, 2025 at 12:07:54PM +0800, Wentao Liang wrote:
> In felix_update_tag_8021q_rx_rules(), the return value of
> ocelot_vcap_block_find_filter_by_id() is not checked, which could
> lead to a NULL pointer dereference if the filter is not found.
> 
> Add the necessary check and use `continue` to skip the current CPU
> port if the filter is not found, ensuring that all CPU ports are
> processed.

Thanks for reworking the commit message.

You should include a version number in the Subject: line, so we can
keep track of the different versions:

https://docs.kernel.org/process/submitting-patches.html

See the Section about "Subject Line".

Also, you should include a brief history of the patches, what changed
between each version under the --- marker.

There is no need to resend, please just remember these things for you
next patch you submit.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

