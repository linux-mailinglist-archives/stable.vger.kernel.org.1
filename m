Return-Path: <stable+bounces-128452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583CCA7D575
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27713B9B4B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2E8227E96;
	Mon,  7 Apr 2025 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MF1uQcId"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3321D3D1;
	Mon,  7 Apr 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010189; cv=none; b=IeW81CQPZH4cPdkAEqy3vxSLdK7g0bSoMQdbB3RUL2grnjAKfwMmCE1QDLJKHNWivrlA9MI8pzlwBbSxTNE9oGeLinuhYX/7ZTHs1ncLEsDXa3s0BvvTdf3FVVNo9H9gXPesETemRbiTAwRcObTNv8k9P4jDRysmo9xEA6lVFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010189; c=relaxed/simple;
	bh=io0E4moshV/LDfFXrbcr6nh9X9BHIltAUho6j+zSBD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXwddgjEB5kJVeNk4MfMbKN5eONXhJGdb3zCCvJQx9rJx6R8RUt8ydJ2HsX5672re8WS3q/1bqYUnLNGy83U6QfY8qAR7Odd0aic3bdYskKuLKZPRzRsEMqmT17f26moe0n9mHBx8fzI7iEtJtWKd2NbnsQBEpBe0B6uJyms0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MF1uQcId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4349C4CEDD;
	Mon,  7 Apr 2025 07:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744010189;
	bh=io0E4moshV/LDfFXrbcr6nh9X9BHIltAUho6j+zSBD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MF1uQcIdJFjJQ/F9wG+SFD47ag5KHaMgOjZ0HEXb9BrGkNCdpVilAqzWEV8ktw0sI
	 QFvf+XSxEEt/f888ALbkLwdHIgWCw2Lq6mv+rA2H97vR0yHhOAWDX11zsqOIEJRuWS
	 GvG70MHxKJDsBlm4NeV+7+BhpIj9UpNpbfL/t+7w=
Date: Mon, 7 Apr 2025 09:14:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 1/1] xen/swiotlb: relax alignment requirements
Message-ID: <2025040751-oversleep-sevenfold-b429@gregkh>
References: <20250407070235.121187-1-harshvardhan.j.jha@oracle.com>
 <20250407070235.121187-2-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407070235.121187-2-harshvardhan.j.jha@oracle.com>

On Mon, Apr 07, 2025 at 12:02:35AM -0700, Harshvardhan Jha wrote:
> [ Upstream commit 099606a7b2d53e99ce31af42894c1fc9d77c6db9]

Wrong git id :(

