Return-Path: <stable+bounces-92929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5901C9C74D3
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109711F21D46
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111392AD21;
	Wed, 13 Nov 2024 14:53:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50A23A0
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509597; cv=none; b=Cs44M3amDoSG8e5UreftgFmt+PGBjD4wHkwKTUapT47EKbaNaJPG2vZJyCGRMolQPlgQ7TPNxJi2LoEjvLt1jRbK3HObnCYr5N1rnKQaJl/A7p6ekdMHVc5gXHlLxBd3/PbdymgKkP9r1JXbZI22DpfbOirH9rQeLdKOxx8g1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509597; c=relaxed/simple;
	bh=YkJ7kmh+rkg794MX9FJyhVTQ7lu6OsLkGObjljpD8CI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQKVMOoyF15eGK1QuUsVyix9zl6Q0zQIrwo4KTa8qUITsU+HV0k7AWxCdH/5kwXHrxHZn7y6LZZ3y0kSCWS8hn2VhZM9FAAuLqribFM32AC95si72qqcJWM8bWd/9JXYmU8eWklt/BN61Uu3xODTNZ31O6Ni6l7Ql78uC3eVleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A47C4CEC3;
	Wed, 13 Nov 2024 14:53:16 +0000 (UTC)
Date: Wed, 13 Nov 2024 09:53:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: <stable@vger.kernel.org>, Zheng Yejian <zhengyejian1@huawei.com>,
 <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 5.4] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Message-ID: <20241113095335.0fc09f6c@gandalf.local.home>
In-Reply-To: <20241113145037.GA7895@amazon.com>
References: <20241111144445.27428-1-hagarhem@amazon.com>
	<20241112104618.4f2720d8@gandalf.local.home>
	<20241113145037.GA7895@amazon.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 14:50:37 +0000
Hagar Hemdan <hagarhem@amazon.com> wrote:

> > > only compile tested.  
> > 
> > You should do more than that. At least run the ftrace selftests.  
> ok, tested v2 and will send it soon.

You may want to run it before and after your patch applied, as there may be
some tests that fail on current 5.4. As long as your change doesn't add
more failures it should be OK.

-- Steve

