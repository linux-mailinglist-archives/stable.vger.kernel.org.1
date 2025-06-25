Return-Path: <stable+bounces-158488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057DFAE77B3
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 09:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8274116BB2D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76791F866B;
	Wed, 25 Jun 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Evu/Cd0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14F1E5B7B
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835091; cv=none; b=ZDLQb07JEfJKQdbMRUhMy3PBuaQQ5PseAY6C64zb28Fq2JYGwJkmkO96lsZmyeYmVcdZTUQ5T7PNa+tJY7C1/LBx3UrU7VYfKySb7tC3FdMz4ff1jFL7QCDNR5MGAs8p3OYN5jZJo9pXX2WL1HkxhrmGVlbLktUQbO4IvptJkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835091; c=relaxed/simple;
	bh=wBhr6J56w/ZiNbviQOGGOWP7clZmcCBlwVCk5XVUESs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEVfCqC4BnGd5iVOviDBHzxtRRUWTVP1ZPNuTfMEepZTGfk6IRxTW2tLfR7Yq+GoPEZMF9zyvIdOTS6Gl4lDhcqzqfZZ357Lekoclsaok7R1OhpzZYRM7Kn+nqZGh161eXDyet4hL0vNRevIAI28RjQdb9DBXb2n8KOWTN3S6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Evu/Cd0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D3FC4CEEA;
	Wed, 25 Jun 2025 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750835091;
	bh=wBhr6J56w/ZiNbviQOGGOWP7clZmcCBlwVCk5XVUESs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Evu/Cd0VvvDnAvdy19vDIRk9GB7+HykkwwyrbxFKPhAr+tto21bllHUpnZRZ5ErOJ
	 OcN5mipVpIh5ICDjpSqVIuSa66qUTnzCjjZyzhdC0Ta7UrDuos/cEMrLWvNTHFCV6W
	 MaXugj00PrVxP73dVKI5jQf331jrPghB1SJs+XJ0=
Date: Wed, 25 Jun 2025 08:04:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>,
	Pavel Machek <pavel@denx.de>, Bart Van Assche <bvanassche@acm.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Yi Zhang <yi.zhang@redhat.com>, stable@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name}
 directory earlier
Message-ID: <2025062506-thimble-unwieldy-9c6c@gregkh>
References: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>

On Wed, Jun 25, 2025 at 11:00:26AM +0900, Nobuhiro Iwamatsu wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> commit fc663711b94468f4e1427ebe289c9f05669699c9 upstream.

4.4.y is long out-of-support by us, and this is in all activly supported
kenrnels at this time, so why is this sent to us?

confused,

greg k-h

