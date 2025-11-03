Return-Path: <stable+bounces-192134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC5C29C88
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 02:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DA43AE31B
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2D2749F1;
	Mon,  3 Nov 2025 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l8s9Jh+9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB078F4B
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133469; cv=none; b=pE+zYVWGXhXZ64926OZWYn193H4xvqYzZkYBLiJrARakThKgGfLXS9qbTQMoF1tVLFX5CKHbfmOEESHjmIOGZ6eZtFDuj/gtaQEu4P73JFVwN/uODjAzevK5Ms6wMUd3OOtBxNs5w953VU2/+DJyEHq6zUzRXG4QOaMOsc3fnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133469; c=relaxed/simple;
	bh=5jHQudhLtgqH0fgL+PkLHDgrFT7stXiWkYCtXSoimXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/Sn61rAJcI5ugQhIZ6mHCjkyTLuT8SLoRNqpmdtQClbMHP63me77TPrVviNAzcjPE3l/tWGRutZi7QUQayDM3/VYJ6+xt2NhjBRwOcbU3ineiRWeA+qVqXCgdJhJcHP0igNivdFLoxfEAvU1l5M5o/KxjpZfMGnWqsgKhAcYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l8s9Jh+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B96C4CEF7;
	Mon,  3 Nov 2025 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762133465;
	bh=5jHQudhLtgqH0fgL+PkLHDgrFT7stXiWkYCtXSoimXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8s9Jh+9roVUzi/431nxACysYGdwGPRZzVhWdN7UKoA+lliB+eZqMM5Qi0kSs0mFR
	 8nZCmfnJj/R2AjkoiuUtE28kKTU6/C3iW0nqWsQja6Eigf5mO79Fr/jUA5tL4ofpLU
	 +Uf8JazoYdO0GCR74ExZShIB81BvednjoWYY1Qq4=
Date: Mon, 3 Nov 2025 10:31:03 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] dccp: validate incoming Reset/Close/CloseReq in
 DCCP_REQUESTING
Message-ID: <2025110351-comfy-untwist-fabb@gregkh>
References: <20251103012307.4017900-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103012307.4017900-1-zhaoyz24@mails.tsinghua.edu.cn>

On Mon, Nov 03, 2025 at 09:23:07AM +0800, Yizhou Zhao wrote:
> DCCP sockets in DCCP_REQUESTING state do not check the sequence number
> or acknowledgment number for incoming Reset, CloseReq, and Close packets.
> 
> As a result, an attacker can send a spoofed Reset packet while the client
> is in the requesting state. The client will accept the packet without any
> verification before receiving the reply from server and immediately close
> the connection, causing a denial of service (DoS) attack. The vulnerability
> makes the attacker able to drop the pending connection for a specific 5-tuple.
> Moreover, an off-path attacker with modestly higher outbound bandwidth can
> continually inject forged control packets to the victim client and prevent
> connection establishment to a given destination port on a server, causing
> a port-level DoS.
> 
> This patch moves the processing of Reset, Close, and CloseReq packets into
> dccp_rcv_request_sent_state_process() and validates the ack number before
> accepting them.
> 
> This patch should be applied to stable versions *only* before Linux 6.16,
> since DCCP implementation is removed in Linux 6.16.
> 
> Affected versions include:
> - 3.1-3.19
> - 4.0-4.20
> - 5.0-5.19
> - 6.0-6.15
> 
> We tested it on Ubuntu 24.04 LTS (Linux 6.8) and it worked as expected.
> 
> Fixes: c0c2015056d7b ("dccp: Clean up slow-path input processing")
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
>  net/dccp/input.c | 54 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

