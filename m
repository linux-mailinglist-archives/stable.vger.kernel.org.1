Return-Path: <stable+bounces-36044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A0899943
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D62C1F2421E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6715FCEF;
	Fri,  5 Apr 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPah/mFf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA715FCEC
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308592; cv=none; b=YV0TU4pPctQWv7ou2wy56MQpPoY6P+Qy73CfP9ytfxandjck6a3mWBvXFvGgyJl8sLDhryf8s+MqFYkcMaF4kYa6o+Rg4BIIxcnYLlNoc08i5W+otsNtR5Ogez/NvFgGbErfHVZwGslnyFsJKBxTw4KkyBbv/dzdr6ZB+8GaB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308592; c=relaxed/simple;
	bh=Jsp+Q35FrCL3rF3giqp7d8A8ccnUhzEyNwetdNkAXmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL9DhGww+etmTmBQ1KBzeAO+2RviIEtQtfbZM9O+/vX+amLVYXkU1rB8klDFOpcI76rpR+AoSeS3Adf61A7DHaLJu+coYFsGzVarqrrDdm+U2oy4CbddncZCQHHs9UantTb7D9IhKBwfkYVgH1PVa/xeV4AFTpIk6ngx849zjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPah/mFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D549CC433F1;
	Fri,  5 Apr 2024 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712308592;
	bh=Jsp+Q35FrCL3rF3giqp7d8A8ccnUhzEyNwetdNkAXmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPah/mFfXIGVJtA+5MemFF+XNBAoyC8A2dUolvpElhXvT6nq1zfM95ZBHoNMx1HCv
	 aUBqGOQBsbZSgOC7hyp3YeCX42lY9tsnL+fzHUMgVm7NsOAehaZn+MtoIHcjJ/p4vG
	 1ZoHB88odm3isA7WeH7xURBzAyY/GJ4AxEKkthl8=
Date: Fri, 5 Apr 2024 11:16:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, eric.auger@redhat.com
Subject: Re: [PATCH 5.10.y 5.4.y 0/6] vfio: Interrupt eventfd hardening for
 5.10.y, 5.4.y
Message-ID: <2024040519-monument-carwash-cfd0@gregkh>
References: <20240401165302.3699643-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401165302.3699643-1-alex.williamson@redhat.com>

On Mon, Apr 01, 2024 at 10:52:54AM -0600, Alex Williamson wrote:
> This is nearly identical to the v5.15 backport, the only difference is
> the split to struct vfio_pci_core_device hasn't occurred yet, so we need
> to use the original vfio_pci_device object instead.
> 
> NB. The fsl-mc driver doesn't exist on v5.4.y, therefore the last patch
> in the series should be dropped against v5.4.
> 
> v4.19.y does not include IRQF_NO_AUTOEN, so this is as far as I intend
> to go with these.  Thanks,

All now queued up, thanks!

greg k-h

