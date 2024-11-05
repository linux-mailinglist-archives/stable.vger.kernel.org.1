Return-Path: <stable+bounces-89789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9469BC61B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 07:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722D91F23034
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 06:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511291DC074;
	Tue,  5 Nov 2024 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sr3DHCoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77D1D5CFF
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789783; cv=none; b=jUR0bczaqO61cm4lDWgEO5RNA6Bfxxrg8Rxdlp8N7yZsrKGXmN7hFu/YJzF7/a5CaoHFb25xXVO9bREyzy3TlEjYFG4s/W2mpI/5qidBrBEyCLWShb9SGux5676y8xlFdi/MLMgRRpz1yS1HBH2GBX31taKHoeHZYwPa2fygWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789783; c=relaxed/simple;
	bh=Qjz5R+Jh2bPMzdB5lf4VVN+SG5soidsOQNA6wkymHkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO7kpKQP6OcxN7chZ2LFVE//GJKA0LeC7opBXWpR+UnW0daXVnzk5sDQkKqONPMdwsyd0IwUwzvzoSazk8nw0vV37BCmv1YoeuNqOkIVSx/eC3BgTEaup6ArvFqiEMHWtbzPsumsDjN6k/WNrYhnhV2qFyaG2rKTEC/N991V65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sr3DHCoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31732C4CECF;
	Tue,  5 Nov 2024 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730789782;
	bh=Qjz5R+Jh2bPMzdB5lf4VVN+SG5soidsOQNA6wkymHkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr3DHCoZ47psz5c5bIcvQtoHSMDqpZziIILVlyIKoV97o2kDW2IcBVS9UrArdl6DN
	 2/Hy00FPxtvkcMJC0eERAJD7BnP3zkGqm+FJjH0Kq/TWF+utuHkn1U9JeXP2mYrc9e
	 2JTwdLFs1cjICySr2FcdYbYtaiKcOQ0IaMbWvN9E=
Date: Tue, 5 Nov 2024 07:56:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org
Subject: Re: net: dpaa: Pad packets to ETH_ZLEN
Message-ID: <2024110525-griminess-viability-f8ef@gregkh>
References: <CAH+zgeH2Cjk3pjgrmZYN45VNa_9v8MA52QRjwdaS9hrKnaJUzw@mail.gmail.com>
 <2024110444-napped-atonable-371b@gregkh>
 <CAH+zgeECVc0soxeGAJq_SJb5e4vYLeDDS2gHi7ujJbOFGusYyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeECVc0soxeGAJq_SJb5e4vYLeDDS2gHi7ujJbOFGusYyA@mail.gmail.com>

On Mon, Nov 04, 2024 at 08:53:57PM +0530, Hardik Gohil wrote:
> Greg when can we expect the v5.4.y release

No idea, why?  Should we do one sooner than expected?

thanks,

greg k-h

