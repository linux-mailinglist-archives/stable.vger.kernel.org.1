Return-Path: <stable+bounces-36401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64989BE2F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357A6284983
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546E657C5;
	Mon,  8 Apr 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5op16r0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A745940
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575974; cv=none; b=YoGU0LdI3xGHfxbhkNswGGjAgllqQ2KKapz/m+1GqDE5dxsyZczl7UV7ixTsK9f9rnw7TxRuCklofRNMOeNBLlyFIll5SddoH1I7A+WBkl1oV6crmMyZTGI+/Lt09l5LOA6CZRSOHH7OOubXazvpKOAzr0EkVNqYJxCaFoqZYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575974; c=relaxed/simple;
	bh=VmzuN/oIVgAfQmhDb7JLOrkVWqx+M5AEzMX8qMZn+jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HL/1EMDshEYfpo9//1GP7iWojpt+l8oaVFjFOndVeBHkZCs20qhr8dHVf5auAab+CFmXRlMdi/CtdqjzJXwTPLAtuEuSXOXpW9ktTScjQT3CRwDvSAImf0qwbt95etbusfxkcpZY18RvmeNhqIIO6fwAEvbrtlAOyXTw7ln+QVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5op16r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA900C433C7;
	Mon,  8 Apr 2024 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712575974;
	bh=VmzuN/oIVgAfQmhDb7JLOrkVWqx+M5AEzMX8qMZn+jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5op16r0aIWq4YeJzab7IMtCXct1lZ6v5DKlVeBj/qvU5xAxltvw+KM2mqIbukp+l
	 FM15vzzw6TfFGyf3RVeiSWuPMfHx7ODgKk8yU3R+kXuCFKZEx0jYffL1AQn+mj18R2
	 bUoTaKcB1B/YCrGBuvkNWCIBHqT27+3+XcD7Knys=
Date: Mon, 8 Apr 2024 13:32:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org, stable@vger.kernel.org,
	"min15.li" <min15.li@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH for 5.15.y] nvme: fix miss command type check
Message-ID: <2024040844-papyrus-bronco-693b@gregkh>
References: <20240407091528.5025-1-ikegami.t@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407091528.5025-1-ikegami.t@gmail.com>

On Sun, Apr 07, 2024 at 06:15:28PM +0900, Tokunori Ikegami wrote:
> From: "min15.li" <min15.li@samsung.com>
> 
> commit 31a5978243d24d77be4bacca56c78a0fbc43b00d upstream.
> 
> In the function nvme_passthru_end(), only the value of the command
> opcode is checked, without checking the command type (IO command or
> Admin command). When we send a Dataset Management command (The opcode
> of the Dataset Management command is the same as the Set Feature
> command), kernel thinks it is a set feature command, then sets the
> controller's keep alive interval, and calls nvme_keep_alive_work().
> 
> Signed-off-by: min15.li <min15.li@samsung.com>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> ---
>  drivers/nvme/host/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Both now queued up, thanks.

greg k-h

