Return-Path: <stable+bounces-152885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13105ADD093
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18B0405C63
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D312264C6;
	Tue, 17 Jun 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q9nP/A5j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB120FAB6
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171623; cv=none; b=rY7r6PWsxHFVwF27IZ560wL/wjLspCYTtVqS8ip+mNf7hJSPrYEEcOUC45TP2fHxT5wNjLeWp1TfdnlysLp+tTLGfmi8+VXiOXeTYK8f/otwvkh5xz3TNk91LYF86HcYOdYSqNLofFyf8orJA0dEDHXYeULOTmONy+TFQtc1J8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171623; c=relaxed/simple;
	bh=2bHjfRS7vwziTyB0qKVGwhxEDEE0Ry+Xn6e45mhWSCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhcVbXoWzq2BzGoF+VFfdLtpShym9dyahGnXbMhshyu+wFXfgo7AvbNTe7fFP8uZsseqlTsvcuLjN4iA2bWPgFb7UhWfluQ78fX28YXqWI6BilbKHvJdPlfHPLkkMGsJtqAB/FiBzOyQ1HDsdJJEMgBaeV61uxUTXx3gW/1covY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q9nP/A5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E311C4CEE3;
	Tue, 17 Jun 2025 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750171623;
	bh=2bHjfRS7vwziTyB0qKVGwhxEDEE0Ry+Xn6e45mhWSCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9nP/A5jwN2gQfQTP1HRapLRIDFzfs9A30Rc8WxjsJZQviaMMddoCfFDjzgNzH+o1
	 tLqDo5WHM6KdoXQ/7QSRjcvIzHE5tUIMqa645eoixSJYWwjN85DzkeFoeyPWtPgN2U
	 D6snsq+o7wwn0z1tB/BvG/yp12a89+8dWVyjmqeo=
Date: Tue, 17 Jun 2025 16:46:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: pawell@cadence.com, peter.chen@kernel.org, stable@kernel.org
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] usb: cdnsp: Fix issue with detecting
 command completion event" failed to apply to 5.4-stable tree
Message-ID: <2025061745-thesaurus-devourer-8bb3@gregkh>
References: <2025061708-cameo-caring-38a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025061708-cameo-caring-38a0@gregkh>

On Tue, Jun 17, 2025 at 04:24:08PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x f4ecdc352646f7d23f348e5c544dbe3212c94fc8
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061708-cameo-caring-38a0@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> Possible dependencies:

Oops, my fault, this only was needed in 5.15 and newer, sorry for the
noise.

greg k-h

