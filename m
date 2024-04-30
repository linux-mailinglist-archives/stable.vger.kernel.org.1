Return-Path: <stable+bounces-41828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774148B6D54
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168FD1F23A91
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A25F194C8F;
	Tue, 30 Apr 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NlY0K5kw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C0194C86
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466995; cv=none; b=X/idF1eKcPdLp4Hwhf83z1EhXBWGpi2QAflH6ykItp+GhxBaVvC2DTbjGt4ybi5VQWnskYWV7/Kl6LRQ/PPQ4k413QRwAfeub53zVsEIiiEReZHHbwo76xGwEpN40lgnPvUsMIK75Kq9Lr7E/OKhw15ExSlyG5naNWSAXac/ojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466995; c=relaxed/simple;
	bh=yyMNMoRKfJR9At+yF2EqurovbVGI9TqL1Gi+KT5Pnps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evgKx0ze0xZRvyTdNuSgl0VGyY3eJ5M2l1bObaQSWNr267I45LVEvAg5PoapupWik0Kv5a7eLjbbiAlmgl6nOCrUDIY7+2w7Abbq0dgzOYToKRORGPptgT6jQ9RqGaTNTXLU6sky3G2eImWZMEuVGIGIno0LPj6k1gwM8oJL57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NlY0K5kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37A3C2BBFC;
	Tue, 30 Apr 2024 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714466995;
	bh=yyMNMoRKfJR9At+yF2EqurovbVGI9TqL1Gi+KT5Pnps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlY0K5kwWLAAIV1mwhsR1YF19tIzu0A1EEnrvVtLkf52Xj+AVm2gu0Gmk46mfr1AP
	 Ct9O0GxG9hoc53aErKhPMfUX71QUNTgAJsnVECk/1RweXDftVjtw1aeKJgG3I/aEq0
	 un1nMDJ5WT7vRuKQCAzZ/O9wkbdKessKEJ6Z6GUs=
Date: Tue, 30 Apr 2024 10:49:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Srish Srinivasan <srish.srinivasan@broadcom.com>
Cc: stable@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
	dm-devel@redhat.com, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, He Gao <hegao@google.com>
Subject: Re: [PATCH v5.4] dm: limit the number of targets and parameter size
 area
Message-ID: <2024043044-eternal-scandal-77ee@gregkh>
References: <20240430083259.13876-1-srish.srinivasan@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083259.13876-1-srish.srinivasan@broadcom.com>

On Tue, Apr 30, 2024 at 02:02:59PM +0530, Srish Srinivasan wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> commit bd504bcfec41a503b32054da5472904b404341a4 upstream.
> 
> The kvmalloc function fails with a warning if the size is larger than
> INT_MAX. The warning was triggered by a syscall testing robot.
> 
> In order to avoid the warning, this commit limits the number of targets to
> 1048576 and the size of the parameter area to 1073741824.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: He Gao <hegao@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [srish: Apply to stable branch linux-5.4.y]
> Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>

Now queued up, thanks.

greg k-h

