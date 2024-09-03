Return-Path: <stable+bounces-72773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D139969670
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBF1C22FBF
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100061A302B;
	Tue,  3 Sep 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXr4BUqS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E31D6786;
	Tue,  3 Sep 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350570; cv=none; b=P7I4Df07dBs6MuE5Kqy72ZSRyd5lDQvQ3IdHUqpz0nuy9HrZHs9kJDehMGulypsdEmlxNrbYBDlq9W0IuiVPqUp55e6Z7tDKmwSJkN/1njG3LhUAtupUSQoG4FEw5rz2GDdNj83QCDlanDSijcgXc3YXwJ5/Cl4FK/425IZb8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350570; c=relaxed/simple;
	bh=pm9Avb8uhuiXPRpvp4WqLHOHFrE0CihtSyTLR0RrJH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqMsHyEu0a0foQnXJrgtWyN5wz1gfd5PVEPgnyK8uklPqpG6J5M/GtXKuVE21vNpKmRTNInLL0f2s/PZjNeVYSTWTpCTDdLL22lywqbUthjNEEB/k6d0EBCKDioyHPJqUQfUzftAZBjyyMtd6EH+3T8cYXy1rSlqWyLFCe15+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXr4BUqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F805C4CEC5;
	Tue,  3 Sep 2024 08:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725350570;
	bh=pm9Avb8uhuiXPRpvp4WqLHOHFrE0CihtSyTLR0RrJH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wXr4BUqSP6hc4FYCcGE6oWbnQX0oj1M6w7Ay4+jdG/iqi/ai6S8fku3fbA5/BfWYl
	 JdoSAgvuAvjEMgH2mvSlFeJKEoLONT4PpdB5IxQ5k1lrceRUKwqcxfqeGM/0Lkt3PO
	 0+fWoLcs2Rm/XL6OyXFk/CJ7p3rQGfPcVS2i7Aao=
Date: Tue, 3 Sep 2024 10:02:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Theune <christian@theune.cc>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Follow-up to "net: drop bad gso csum_start and offset in
 virtio_net_hdr" - backport for 5.15 needed
Message-ID: <2024090309-affair-smitten-1e62@gregkh>
References: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89503333-86C5-4E1E-8CD8-3B882864334A@theune.cc>

On Tue, Sep 03, 2024 at 09:37:30AM +0200, Christian Theune wrote:
> Hi,
> 
> the issue was so far handled in https://lore.kernel.org/regressions/ZsyMzW-4ee_U8NoX@eldamar.lan/T/#m390d6ef7b733149949fb329ae1abffec5cefb99b and https://bugzilla.kernel.org/show_bug.cgi?id=219129
> 
> I haven’t seen any communication whether a backport for 5.15 is already in progress, so I thought I’d follow up here. 

Someone needs to send a working set of patches to apply.

thanks,

greg k-h

