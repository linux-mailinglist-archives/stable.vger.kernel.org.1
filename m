Return-Path: <stable+bounces-9253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C382B822AE8
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 11:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6792839D4
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898A1864A;
	Wed,  3 Jan 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZeyxjdPS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222B18623;
	Wed,  3 Jan 2024 10:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3436C433C8;
	Wed,  3 Jan 2024 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704276306;
	bh=g+ZKH06KBL7DIg7DPOviGv1Y/WJk5xj658hYOPt0RNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeyxjdPSyN+ABIWxDVJt5rf6vZvDPkmr0MNzmSbIi5jrLWWp6YESFfK8yQzFzwsLv
	 WDAlcxmljKUFt+lBTZcCaa2SJK/espwmoYzydn4EYXIuC8q09go+e69Cnb0QcEiejW
	 BXbcEXDvAvF13lctxbcHIOall1r/FVe1WO3jqi80=
Date: Wed, 3 Jan 2024 11:05:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 133/156] ring-buffer: Remove useless update to
 write_stamp in rb_try_to_discard()
Message-ID: <2024010357-seismic-unworthy-b876@gregkh>
References: <20231230115812.333117904@linuxfoundation.org>
 <20231230115816.705008371@linuxfoundation.org>
 <20231230164736.3b8c86c4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230164736.3b8c86c4@gandalf.local.home>

On Sat, Dec 30, 2023 at 04:47:36PM -0500, Steven Rostedt wrote:
> On Sat, 30 Dec 2023 11:59:47 +0000
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > [ Upstream commit 083e9f65bd215582bf8f6a920db729fadf16704f ]
> 
> BTW, here's a fix for 6.1 and 5.15

Now queued up, thanks.

greg k-h

