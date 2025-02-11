Return-Path: <stable+bounces-114855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB06A3059C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A8A3A175A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5F1EEA37;
	Tue, 11 Feb 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ji96zjFj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFF26BDA8;
	Tue, 11 Feb 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261946; cv=none; b=Bxv0HeY1/NbVV0nRpr3zc3LBQ6P2OdVjfy2vUGdk7XyUC12L/Dqyly9Cjex1+ZNsZOBQivF/a6pfuuf2WdubftYjCi8PLYY7dXnGnYk62vExUTVEIHqytgbDCGKpUD9wJcckUAaKOlaA9C75vcG2JOTT6BuCYU0mTRD1HjoozhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261946; c=relaxed/simple;
	bh=lvX32DBBI6x6HgF44D0PtbcsbkCy7X+vUdXbuGlBUdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp8O1ALZrNCKHfPCXjd1YmO/9p4WMpjLljUpNCDuwMlvFqkoSZkZ92SBVf5EJKMhBZfZiOe0RQ7nxYyHZdiYE4VUdHyOLaWrfgOMvjDW5K4AK8eg/fMM2ouJXaVui6KoyDz4ecEWf3+e+lfm4jq0y/QAuEPMTPeq1u1GSiVmUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ji96zjFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C099DC4CEDD;
	Tue, 11 Feb 2025 08:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739261946;
	bh=lvX32DBBI6x6HgF44D0PtbcsbkCy7X+vUdXbuGlBUdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ji96zjFjb2272l8T4NEKSpWoCXOEwK7fNmQ69i5X6RiyUxvZ/uh9ZH7lN6NWef+0r
	 Cb2wdRDcfybO+CG488kskiGzy2EahipnSP8BpEBMDOpyjdBXW6HLMnhTL2AtsXBqzq
	 EHZzCDEpj1hx45j5g9wFGCxlqvARTCJGBzA8Qm9M=
Date: Tue, 11 Feb 2025 09:19:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6.13] fs/netfs/read_pgpriv2: skip folio queues without
 `marks3`
Message-ID: <2025021115-backlands-violin-5f91@gregkh>
References: <20250210223144.3481766-1-max.kellermann@ionos.com>
 <2025021138-track-liberty-f5d9@gregkh>
 <CAKPOu+-Mi1oCNvk3SJnui3484wpfru3fE1gA72XVcX77PFOjVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-Mi1oCNvk3SJnui3484wpfru3fE1gA72XVcX77PFOjVA@mail.gmail.com>

On Tue, Feb 11, 2025 at 09:05:44AM +0100, Max Kellermann wrote:
> On Tue, Feb 11, 2025 at 7:30 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > Note this patch doesn't apply to v6.14 as it was obsoleted by commit
> > > e2d46f2ec332 ("netfs: Change the read result collector to only use one
> > > work item").
> >
> > Why can't we just take what is upstream instead?
> >
> > Diverging from that ALWAYS ends up being more work and problems in the
> > end.  Only do so if you have no other choice.
> 
> Usually I agree with that, and I trust that you will make the right decision.

I defer to the maintainers of the subsystem here to make that decision,
as they are the ones that will be getting my "FAILED" backport emails
when things fail to backport due to this being out-of-tree :)

thanks,

greg k-h

