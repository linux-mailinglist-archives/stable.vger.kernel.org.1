Return-Path: <stable+bounces-194996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03791C6561D
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA154367AF1
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE130147C;
	Mon, 17 Nov 2025 16:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmYnfFCQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B2301485
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398766; cv=none; b=RQHcqpKVJLMBYw1c0qzuGFjdbjan4ana0kEZXt8LibT7MRaSYiY47QwiSv08NG2oDkwyChtWUTQ5w96BUMDgW6i7cv9mFwlz9MV5JTy3Q9xdhU+vFzlU63ppPzMim4Ki1bldAG+0VbkC3t+iy/LwP+aCmoPMzYegnqIDe3rzgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398766; c=relaxed/simple;
	bh=aeqXwPJzYn7SGONYH0iOjUdTF4D4joAXNRIjQZYaFMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWutjgKDZ+Gh+vDk7ByynRHjjpcDcsbTHdtdQDhKiEYVbpv5gXV+LGIMEMyFPv3GnOE0BAfqyaVy03Nc+XDRotR0Z2oJSlbsBqzmBvrmBTniTvW/XR0B1aNDw9S5uvLLkJWYW6Wn8P+JGQcp5RaThvKSyS3xEjKFEp0Z+GhpU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmYnfFCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C397C2BC87;
	Mon, 17 Nov 2025 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398765;
	bh=aeqXwPJzYn7SGONYH0iOjUdTF4D4joAXNRIjQZYaFMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmYnfFCQuaxMDkVASQVWvQAxrbw7T8d8VU1safSvtFvpVzlMlGevbV+Bk+xZD8o1y
	 Ob/aE2VXxyfl8jEGZB+KJpsc5bvL8PKbI/Hte7HjWPF/MBCrMUrWuD6ythf8JJUk+g
	 Dj73qJZVCE1hqKM01NV1scz1nfMhi+TOBEl/ZyscQ5PxUSBHAJIpAvWG4fQM9TI6vc
	 kzT1nORe0j8VW6uCg8GxAh1EI5Nk0v4MQuantPGv6PcpycCmR9hbRObXlgpO50GCxn
	 VEpfbqgrqHTc2JpLLdQ4hZ42UYTOQ2cbPJ4Ktsas15TbOVvgqWxGphsX7x4WiINFo0
	 gp2schN2ENowQ==
Date: Mon, 17 Nov 2025 09:59:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, mpatalan@redhat.com,
	james.smart@broadcom.com, paul.ely@broadcom.com,
	justin.tee@broadcom.com, sagi@grimberg.me, njavali@marvell.com,
	ming.lei@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Two NVMe/FC bug fixes for -stable
Message-ID: <aRtUa0qhXJVFlyr-@kbusch-mbp>
References: <20251110212001.6318-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110212001.6318-1-emilne@redhat.com>

On Mon, Nov 10, 2025 at 04:19:59PM -0500, Ewan D. Milne wrote:
> This patch series contains two fixes to the NVMe/FC transport code.
> 
> The first one fixes a problem where we prematurely free the tagset
> based on an observation and a fix originally proposed by Ming Lei,
> with a further modification based on more extensive testing.
> 
> The second one fixes a problem where we sometimes still had a
> workqueue item queued when we freed the nvme_fc_ctrl.

Thanks, applied to nvme-6.18.

