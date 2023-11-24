Return-Path: <stable+bounces-305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AF7F788E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87948B20EF3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39933CD9;
	Fri, 24 Nov 2023 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYlJYcgC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5433CD8
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93019C433C8;
	Fri, 24 Nov 2023 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700842018;
	bh=LSBIBKFMekHk335Hg+9krY1qLHynJXTCFQeK7zoVfHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYlJYcgCBEd2Wso/eF1Uy8JRa8v/KSRaOa05vuf5J123vexsJVQaubknPstHdx7vM
	 n/kxtz3tKiJzISBhZNdZTNeyo9UeyqQ8Fx5l3YE43wVdLdFqt7nBlcSAC/XghRv1Se
	 cDTXcnN90Lry7gihDy/i1XMXt6OPcW/jS5tGvZz4=
Date: Fri, 24 Nov 2023 16:06:46 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: beaub@linux.microsoft.com, mark.rutland@arm.com, mhiramat@kernel.org,
	stable@vger.kernel.org
Subject: Re: [v2] Re: FAILED: patch "[PATCH] tracing: Have trace_event_file
 have ref counters" failed to apply to 5.4-stable tree
Message-ID: <2023112417-vengeful-uplifted-7782@gregkh>
References: <2023110614-natural-tweak-9ee4@gregkh>
 <20231116112445.7c35e366@rorschach.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116112445.7c35e366@rorschach.local.home>

On Thu, Nov 16, 2023 at 11:24:45AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Date: Tue, 31 Oct 2023 12:24:53 -0400
> Subject: [PATCH] tracing: Have trace_event_file have ref counters
> 
> commit bb32500fb9b78215e4ef6ee8b4345c5f5d7eafb4 upstream.

All now queued up, thanks for the backports.

greg k-h

