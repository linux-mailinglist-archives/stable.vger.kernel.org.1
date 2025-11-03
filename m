Return-Path: <stable+bounces-192286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1536C2E770
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 00:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 301974F22D5
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 23:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339130DD18;
	Mon,  3 Nov 2025 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arUhlo4T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5830BB90;
	Mon,  3 Nov 2025 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213480; cv=none; b=tcxi8+avm/qCBbI+cf/vo+HJoP35ycRpf0luo9ZlY9NDkuOQQBWzD02lLgaJrzkMiutRc2f5nv0eIEnzxawd3af0ly1zfg4e04C+0BkUfoukJYE6hYbzdqIlN42voP91wcZeGniVhDg8WCRISrW2Y3+zdHwaPfWPrzhvVbFZW+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213480; c=relaxed/simple;
	bh=51ZuLqa9vgyNyF8Hwj/WsY0DqAHS9YKk1MRGYf4BaQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/5ltBZRVfL+h5fz36ATLSv8xM15OofV2+yNO6BFYSfBxk0uSu+hEqQmxPJvbOvtAiPWAD44Fq4Ilgc9r5ZxoN4sUtVyQEFLAOM2yGaN5wtm3j9Gw96CJatD7InDFkiOK7h/tUkKzT6UlJWyqdOPNCgOu4rMP54Y0Lz0chfjnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arUhlo4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D4DC116B1;
	Mon,  3 Nov 2025 23:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762213480;
	bh=51ZuLqa9vgyNyF8Hwj/WsY0DqAHS9YKk1MRGYf4BaQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=arUhlo4TMHF4gzRUEw//blsavMXXIDWpdr0u9EFsI7EnUAvVMrjixCKALg/UCc4Yp
	 ojW6teEglrQ0PAzUKgUS0p2qIokbKAl5lEPlhM7AZ8PpB4tlNkQRwTPkUDylhsqabC
	 +xEuY2XHCGdQ0/Z+dU5hqttiQsjK6FYcxsDTL7DuAn9zQidfmNRYQtQ1MJ4yisZ7R6
	 ATm9rQo1fbvfcTvvUpuFg218s0Akfr0w5cF5wjhmN0G+ZHUoR0htY40M+5GeT/AxcT
	 1n/3K95ZWLbBffYBPYjavL6P1/zw524xCOzT45eYASd4nCJBUf+RUkHw++KFiIqjnm
	 V2OuKjiRw1FAQ==
Date: Mon, 3 Nov 2025 15:44:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net/dccp: validate Reset/Close/CloseReq in
 DCCP_REQUESTING
Message-ID: <20251103154439.58c3664c@kernel.org>
In-Reply-To: <20251103021557.4020515-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20251102155428.4186946a@kernel.org>
	<20251103021557.4020515-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 10:15:57 +0800 Yizhou Zhao wrote:
> Following your instruction, we read the documentation at https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html.
> We found that the stable documentation normally requires an upstream
> commit before inclusion in stable, but here an upstream commit cannot
> exist because the subsystem was removed. Could you please confirm
> that this can proceed as a stable-only fix for the affected LTS
> branches?

Yes.

