Return-Path: <stable+bounces-39398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3528A4869
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 08:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4651C2169D
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 06:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10F61EB5E;
	Mon, 15 Apr 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTubb2UE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8311EB36;
	Mon, 15 Apr 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164029; cv=none; b=jY+rIjk9LPs7liDwulkBFxVc59L/tDjlDlaqJhaokED2qV5lI0o3to4tSBxtFzAjtESbyXaNyylnqZ79+1Vr40fwMoj8vhfpCy1q6i2C08Xn/XztRaCtmFDLRzBJU2Y6X3bEdLo9iDYcbrF06vx0hy0pS+ozGl8jhZX5qqcF99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164029; c=relaxed/simple;
	bh=gJH7c72oR+IyKtC4jk+rhP58fP5HmbqZlgRE4iVaT30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI77oQDbwhNYRrLkhV4lRMRHWpswTiv6IelgRg95R+kGF0MPMDvA08nBDz2VroLySAbIefh8QG5V7IdwxULk+852kJoqo44d9Na3r4huqSfq7a8RV2ijKQje3eXUwHsdqIka3JKXUllYa7XM9STLlWbGw4aAZiJEHp7IZqE8yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTubb2UE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD8AC113CC;
	Mon, 15 Apr 2024 06:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713164029;
	bh=gJH7c72oR+IyKtC4jk+rhP58fP5HmbqZlgRE4iVaT30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTubb2UEi5QBv6chWiaakROMh8HPOuQX2NjlfikKnBSbg2c7DTRyGDttg2MwdIe/L
	 WUKIFocwmpjpX1XCdsUBX79bBtwLSLxS24DwbJKcunnphjfH/U+xfWHO/Woi3++dEw
	 Sl3ggHvRqV0q9LDrUpPxbtW/DTnJfa/dzwTJq/YFw46AsYYOIiD+t8NJVQtj0D6g+G
	 atQd5289hiHNngOepmi8lWna+qB69CrgVKvkLjzcuETBUgj30OslMJDHSD1PKwoS1F
	 nNNjFYrRWFF9mjarb6OEB2u56o4robySvz/zxt8S32Xrh0WUFGXor4ZqjT/noJQLrv
	 e4mbmoWEqDTlg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwGDq-000000004lA-2Jo9;
	Mon, 15 Apr 2024 08:53:46 +0200
Date: Mon, 15 Apr 2024 08:53:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Lars Melin <larsm17@gmail.com>, Coia Prant <coiaprant@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] USB: serial: option: add Lonsung U8300/U9300 product
 Update the USB serial option driver to support Longsung U8300/U9300.
Message-ID: <ZhzO-re7GMmI5fbP@hovoldconsulting.com>
References: <20240402073451.1751984-1-coiaprant@gmail.com>
 <64053ff1-c447-45c5-ba87-e85307143dd4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64053ff1-c447-45c5-ba87-e85307143dd4@gmail.com>

On Tue, Apr 02, 2024 at 03:09:12PM +0700, Lars Melin wrote:
> On 2024-04-02 14:34, Coia Prant wrote:

You're Subject is missing two newline characters to separate the commit
summary from the commit message.

> > ID 1c9e:9b05 OMEGA TECHNOLOGY (U8300)
> > ID 1c9e:9b3c OMEGA TECHNOLOGY (U9300)
> > 
> > U8300
> >   /: Bus
> >      |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=option, 480M (Debug)
> >          ID 1c9e:9b05 OMEGA TECHNOLOGY
> >      |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
> >          ID 1c9e:9b05 OMEGA TECHNOLOGY
> >      |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
> >          ID 1c9e:9b05 OMEGA TECHNOLOGY
> >      |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
> >          ID 1c9e:9b05 OMEGA TECHNOLOGY
> >      |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
> >          ID 1c9e:9b05 OMEGA TECHNOLOGY
> >      |__ Port 1: Dev 3, If 5, Class=Vendor Specific Class, Driver=, 480M (ADB)
> >          ID 1c9e:9b05 OMEGA TECHNOLOGY

Could please use the more condensed output of the usb-devices command
(for both devices) which is better suited for a commit message?

> Reviewed-by Lars Melin (larsm17@gmail.com
> 
> added the maintainer to the recipient list

Thanks for reviewing, Lars.

Coia, you can include Lars's Reviewed-by tag when you send a v2.

Johan

