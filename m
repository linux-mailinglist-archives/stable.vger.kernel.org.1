Return-Path: <stable+bounces-167124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3568B224EB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650BA172ED7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED12ECD31;
	Tue, 12 Aug 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C50oBxhg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B62ECD27
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995659; cv=none; b=k5nMIC4l7f33SuTPOK1nLEPp+3EnfEkebz7unmaiTY2j4zxbB+tbkIw/4hXb5+heOpLnmyE3DyTegMLmJ4jKVC6heYS9VA317wXZy6WOD0czl/sMleILcjSaVzMVp33CJID14L+fCGuUWekJ1UzXac0cQFID6wC/ssJiFlgEKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995659; c=relaxed/simple;
	bh=KVmqIaJgFdWr5BRwfonjDt+J+FlnGBzcS92isBnBYwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAsvigaPvRx/gNsVneA45NSGh53QuWI7OB35CT0j0GftfFRifSQOhjhSgjm6aB32/OsQlt6cQTpW+Rx7O/8GFx6n1ahNSC3q2sauE+63kvVWZGkFHN+rMbJpgkkRDvC+cSrW+YSwLXiOEycwpLCt7v82/YAa0SO587D8dw54MNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C50oBxhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C752EC4CEF0;
	Tue, 12 Aug 2025 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754995658;
	bh=KVmqIaJgFdWr5BRwfonjDt+J+FlnGBzcS92isBnBYwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C50oBxhg8P3ipmyOwJJ9croZKdFpfQhDBSt//gTRJzPolK0KUvncrV/x8rP2kRsNq
	 t//daL7mparMp4wCvZXoVp6u0+jVXLeoOB/TGUlBTs+Epio5RNnRRWMeq4MIPymXbM
	 S79ujYNe1fO3bG1vGZGEj/obm/p7PybFvkz4u50U=
Date: Tue, 12 Aug 2025 12:47:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.12 1/6] drm/i915/ddi: change intel_ddi_init_{dp,
 hdmi}_connector() return type
Message-ID: <2025081201-recent-observer-a8cc@gregkh>
References: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
 <qtx56p35nqiuds6hvhi5d2rfl2hdh7xir7qjvoduw2n7hkyj34@4hq75a4bh23i>
 <4r4r7x4b63f6366ep5ijnve6ru5m5xv65puarv3kwrsv47t7er@xuk6hsipfe3u>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4r4r7x4b63f6366ep5ijnve6ru5m5xv65puarv3kwrsv47t7er@xuk6hsipfe3u>

On Tue, Aug 12, 2025 at 03:35:54PM +0900, Sergey Senozhatsky wrote:
> On (25/08/05 11:11), Sergey Senozhatsky wrote:
> > On (25/08/04 19:16), Sergey Senozhatsky wrote:
> > > From: Jani Nikula <jani.nikula@intel.com>
> > > 
> > > [ Upstream commit e1980a977686d46dbf45687f7750f1c50d1d6cf8 ]
> > > 
> > > The caller doesn't actually need the returned struct intel_connector;
> > > it's stored in the ->attached_connector of intel_dp and
> > > intel_hdmi. Switch to returning an int with 0 for success and negative
> > > errors codes to be able to indicate success even when we don't have a
> > > connector.
> > > 
> > > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > > Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Link: https://patchwork.freedesktop.org/patch/msgid/8ef7fe838231919e85eaead640c51ad3e4550d27.1735568047.git.jani.nikula@intel.com
> > > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > Just for the record, this series fixes multiple NULL-ptr derefs
> > in i915 code, which are observed in the wild.

Note, if you need/want some CVE ids for these, please ask at
cve@kernel.org.

I'll go queue these up now, thanks.

greg k-h

