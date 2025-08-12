Return-Path: <stable+bounces-167239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5CB22DFF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A3169354
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DA2FA0E9;
	Tue, 12 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AcLr25l2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFB2FA0E6
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016801; cv=none; b=EerLL7Mi/6ulW3Ew/JNqlKLvVPTqkMaNqvdAY5t4ShxIgje95SHGsZN1SLNP4re1A5GbM7uwr7j5AwXYevk7pP1oGF56v9Bkl9T2oYJKyU0bkLy9ZEN+ljHQYBgjYsFay/n81rVbi2BoWAYlkTYyOmJCUQw2TgZXS52IOp+n3xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016801; c=relaxed/simple;
	bh=rcqs2ZUwN7HFYlv6v2gnbQohXlidJC6hBIKU9hOar0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1miVJIVqxsd+XUgeFY50LTU6jo5A50pDVlkThiLraqgv7IshQkP+/zO8nciKqxg89XirXQ1hzlK/DaV/3D/WXE/crWz9CCaJqgnH+UpbHcfYhdc+xrBiMHx1T7dSFRygTZrPU6aixNr2IuZanyRL2RGT+OeEnfn+WeuwdmKOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AcLr25l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA654C4CEF0;
	Tue, 12 Aug 2025 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755016801;
	bh=rcqs2ZUwN7HFYlv6v2gnbQohXlidJC6hBIKU9hOar0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcLr25l2xNKH87b8j2R9kcnz0VwmC5tSlk3IjxGrlRT0yfn546d3gWBcspE1Yw5nG
	 gGxLQMALLanFeipCFmIVE8ugbLOZLknCQA5lGriObNWZqGF4D6VHE1CkO7xAcP5h7D
	 cmPmomigmTTSnGeCqwHCCIngEEwcdelVOqWYAu/A=
Date: Tue, 12 Aug 2025 18:38:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, stable@vger.kernel.org, vbabka@suse.cz
Subject: Re: FAILED: patch "[PATCH] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got" failed to apply to 6.16-stable tree
Message-ID: <2025081229-pounce-idealize-9144@gregkh>
References: <2025081237-buffed-scuba-d3f3@gregkh>
 <CAJuCfpE+Rj5J-RpDEnws=8qydVUGFf=QE215qtaztuTZLGB-wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE+Rj5J-RpDEnws=8qydVUGFf=QE215qtaztuTZLGB-wQ@mail.gmail.com>

On Tue, Aug 12, 2025 at 09:34:06AM -0700, Suren Baghdasaryan wrote:
> On Tue, Aug 12, 2025 at 9:18 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.16-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Yep, that's expected because 6.6 does not have lock_next_vma()
> function. I'll send a backport shortly.

You mean "6.16", right?

