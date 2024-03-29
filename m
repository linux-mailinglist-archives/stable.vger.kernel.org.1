Return-Path: <stable+bounces-33719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E7E891F2B
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DC3288DF1
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114C18AF8;
	Fri, 29 Mar 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNNgOoBP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32C101D0
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716753; cv=none; b=rS8sIhey6qAJcp92b9y+5q7uuNHEmg8DgFu7eDpqvq6d7yv5dotVOwnFhgZ43VyH885N3qcEhkWx2BehDjS2pAWq2Jsmu+/dFLAGPgmhmM4jQWMXMxOkX1HWLiaGsxlziCGZYgvtH5lICfL3W1JFT+uDynTNYoo5AXhDK5uR5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716753; c=relaxed/simple;
	bh=VBfgxF79nV98CV0pHCWQFcxZVNJ2Ga80pga3451XEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/WmdRP7vO1Gwoo9Aa/7ovH1/Eh1hDzFB822xyuzKyMd6SJBz/xcpC0Wug7W4swaGlnCspSlNjjVntIhHasEqgl/m7R9XJJeI5Wt8oFsHoG/5s5xprRKKtsbNY9nvXuKJNftMsDdThox3kyMNpVgvUZ7QCxFd7G2+U0srF7V5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNNgOoBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58BEC433C7;
	Fri, 29 Mar 2024 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711716753;
	bh=VBfgxF79nV98CV0pHCWQFcxZVNJ2Ga80pga3451XEUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNNgOoBPbCq9MksmM8nEchNj3IYwB/yxnT1QUyOPpOmi1NH84o4BtK+6jvEA9iq4j
	 fk51yZUiRRjpcx6th0JJdjzys16hXKK92nrpJFA4Iwbl/AiyCDttoJD8W49sul4fXe
	 JYpP6h6auexCG3/7OSsHF8NEiOLIcME8Ki5rC4Xs=
Date: Fri, 29 Mar 2024 13:52:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH] block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()
Message-ID: <2024032918-exploring-conclude-a5eb@gregkh>
References: <a764cc80-5b7c-4186-a66d-5957de5beee4@cybernetics.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a764cc80-5b7c-4186-a66d-5957de5beee4@cybernetics.com>

On Wed, Mar 13, 2024 at 10:02:23AM -0400, Tony Battersby wrote:
> commit 38b43539d64b2fa020b3b9a752a986769f87f7a6 upstream.
> 
> Fix an incorrect number of pages being released for buffers that do not
> start at the beginning of a page.
> 
>   [ Tony: backport to v6.1 by replacing bio_release_page() loop with
>     folio_put_refs() as commits fd363244e883 and e4cc64657bec are not
>     present. ]

Now queued up, thanks.

greg k-h

