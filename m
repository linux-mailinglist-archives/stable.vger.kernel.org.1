Return-Path: <stable+bounces-21781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530885D143
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 08:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E550B1F2219C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 07:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ADF3A8F5;
	Wed, 21 Feb 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TK7z4A2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB433A8EB;
	Wed, 21 Feb 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500357; cv=none; b=Y1So+cSPodP47J27azpxeiTiSzdpe6SKKIIqDl3qy5AjDiXE36HJ8hkzpLavNREh79cTLG6LjGqjz7WBd5GU0U1Bs7yr1tFBipeES9YRVsAPy1KR7sEDp0FmipUO7cyHOn6opZ0GEAwzBtQLZWpWwfj+XBqDroC0/xxZ9GmsjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500357; c=relaxed/simple;
	bh=op5fWlExgMsCwMefzUJDzONbKwDlFAhLrcSceWU+1oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQVf2k6WWfG7LMpbBAjgn+4aEzSP3Y2seAtD0I4imxaA2DTOuHADLBYkY/nhFRjX3xACrDIynHfwlAkDDlrkqhfKjvvafQQ96UNw8ojwsWE8wuvIU3ReykS3gwj21yzSmuaorWruyLtgquHK+K08FC/ZYKnz/W1lFoSWUp4DvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TK7z4A2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627DFC433F1;
	Wed, 21 Feb 2024 07:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708500356;
	bh=op5fWlExgMsCwMefzUJDzONbKwDlFAhLrcSceWU+1oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TK7z4A2iulmcJ6v9yw36JIvUUvnJMpO3rPXAOmXCRLL0IEBKKFnTuAxzVTSVAmr21
	 F2A7XrhZBKWL32Bow74/vOKgEkhgEewZAzFvLDMWynDZDm48CDK0VY2GhwkU6aobms
	 fuHp0u+RObCkc6hF2zFrVivl5k6QIdU0xvhXG3dw=
Date: Wed, 21 Feb 2024 08:00:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	stable <stable@vger.kernel.org>, Xu Yang <xu.yang_2@nxp.com>,
	kernel-team@android.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] of: property: Add in-ports/out-ports support to
 of_graph_get_port_parent()
Message-ID: <2024022149-bartender-wrangle-7f93@gregkh>
References: <20240207011803.2637531-1-saravanak@google.com>
 <20240207011803.2637531-4-saravanak@google.com>
 <CAGETcx9eiLvRU6XXsyWWcm+eu+5-m2fQgkcs2t1Dq1vXQ1q7CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9eiLvRU6XXsyWWcm+eu+5-m2fQgkcs2t1Dq1vXQ1q7CQ@mail.gmail.com>

On Tue, Feb 20, 2024 at 04:47:35PM -0800, Saravana Kannan wrote:
> On Tue, Feb 6, 2024 at 5:18 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Similar to the existing "ports" node name, coresight device tree bindings
> > have added "in-ports" and "out-ports" as standard node names for a
> > collection of ports.
> >
> > Add support for these name to of_graph_get_port_parent() so that
> > remote-endpoint parsing can find the correct parent node for these
> > coresight ports too.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> 
> Greg,
> 
> I saw that you pulled the previous 2 patches in this series to 6.1,
> 6.6 and 6.7 kernel branches. I really should have added both of those
> Fixes tag to this patch too.
> 
> Can you please pull in the patch to those stable branches too?

Sure, what's the git id?

thanks,

greg k-h

