Return-Path: <stable+bounces-192104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CAEC29A96
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 00:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48A2D4E7ECC
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A9252910;
	Sun,  2 Nov 2025 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOK8BrIy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC21B424F;
	Sun,  2 Nov 2025 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762127670; cv=none; b=FewBZ1kiGoEoJiMl2GUEXjCtT1VP9Zb69XW7pg/EEtb2tOW7FEF24m5FA9kYFncbev+7swrSIVA1FemSovHDYLgibex/0nqTYtmau+zuxVG2cXwfdG9WhcR5YI5Q/+Qu4gu/k27wUaTm95+4qnfPVAjr+T+sY4gdm/1v7RJgyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762127670; c=relaxed/simple;
	bh=6F3urQDwHQpVGZsVQrXPtlfOh0jh1i65cOn7YmZ3QCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFs8cTXZJnNPjXOwASXNmYKU6IF+VWeIahoF1e86P1InFw+HcDJDPjb942CFrunajjudF02uCRYieW3Ew/mOuhL47nxVtpCk7UDWRYGAaN3p6ntExrgQ5KOO4xiML0VoKLUtTvn3JLfvDw1Toq85oUYANwoRz3fNQnAySer9tok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOK8BrIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C473C4CEF7;
	Sun,  2 Nov 2025 23:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762127669;
	bh=6F3urQDwHQpVGZsVQrXPtlfOh0jh1i65cOn7YmZ3QCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gOK8BrIye5AmXLRTnd4+epANbwSEKFQgSdXQ0IxUnY9fQTYeWjKxdM6Qm6RqZopZ6
	 vbQWTMKrXKTZYwI3FGvjT5X9A7QB1DH/WQiVlGI9S5aitnVBqMlp2UJFKWbgHjMB/0
	 TWb/n3N9VWwXMrMA79wxw65hBPgEa6DPAoBblQlkVFngnN5/VXtr8+mwW9eDN4T4t1
	 f0maqGgq1a5k6wrsi0E9D9Tp2+v/MBj/Laueba5X3lkPm3fLeEUesfrNdeScg2/r6p
	 xjldUD/RsrMK/OocOT5NgAeBerlIIPLpKWw9QrLTU8xDDU4aSJSHeBZSY53uYYufQ6
	 3ybSZE+MTh50w==
Date: Sun, 2 Nov 2025 15:54:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net/dccp: validate Reset/Close/CloseReq in
 DCCP_REQUESTING
Message-ID: <20251102155428.4186946a@kernel.org>
In-Reply-To: <20251102054524.3972849-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20251102054524.3972849-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Nov 2025 13:45:24 +0800 Yizhou Zhao wrote:
> Dear maintainers of Linux kernel, this is a resend version of the patch
> with a clarified commit message based on the previous feedback
> <CAL+tcoCJf8gHNW9O6B5qX+kM7W6zeVPYqbqji2kMqnDNuGWZww@mail.gmail.com>.

Please stop resending this To: netdev, this code doesn't exist upstream.
Please consult documentation on how to submit a stable-only fix.
-- 
pw-bot: nap

