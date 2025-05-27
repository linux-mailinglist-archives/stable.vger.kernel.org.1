Return-Path: <stable+bounces-146460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB2AC5323
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298211BA118C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3E8267B73;
	Tue, 27 May 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="b7EjclcV"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE019E7F9
	for <stable@vger.kernel.org>; Tue, 27 May 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748363928; cv=none; b=m8YqCmROp/Mav1Eiy8LJ8VeACZKithfiG5gF06QoSfDej1zg7RU5FTLQHaGmIhIUiLWA6Xgg8/FZEmzalXK9AE+OxRx8q2PA1nOCTNOHGqQ3MiP+CnPbAjvlSpBgDhMZNxUHsFjxfVrH+cz1s/jV9f3oyaLTOceMyCVFcvMBnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748363928; c=relaxed/simple;
	bh=AnWgM8Rts5STzVt1NmumhNAaeaS1CRYHnAS95osahfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhvycm6JDBFPfJiU+UzGi99Q9ZJql0hZtGX7bE2VNUe72ufcnJNICK8i4JaK882q2IuHP9+svk46GNPeHczfyGjLN8lSwVFc0ZYlvDZyVVhCEL+lFtstCh6/2UAuOCk6ULI798chTNMVYJJ+2Gq8F8W0bDfbS/UyNT/A5BX03lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=b7EjclcV; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1748363922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnWgM8Rts5STzVt1NmumhNAaeaS1CRYHnAS95osahfE=;
	b=b7EjclcVSpMXmItDA8AZ1pmWijdD6sZL1cNt1gT7os3lDqtWLvQtkrlFfuY/b6nH6L1Hf6
	pdECl99ah9DHttAQ==
Message-ID: <35cbb1ab-12ef-473e-8c09-2135a077c3a3@hardfalcon.net>
Date: Tue, 27 May 2025 18:38:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "libbpf: Pass BPF token from find_prog_btf_id to
 BPF_BTF_GET_FD_BY_ID" has been added to the 6
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250522210809.3119959-1-sashalkernel!org>
 <97e0dda6-b2f3-4433-b19c-dbc5d538669c@hardfalcon.net>
 <2025052724-backstab-activator-702d@gregkh>
 <26815461-6d90-4b18-834f-520b4dd814a1@hardfalcon.net>
 <2025052705-sandbar-ambitious-ed02@gregkh>
Content-Language: en-US, de-DE
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <2025052705-sandbar-ambitious-ed02@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2025-05-27 17:50] Greg Kroah-Hartman:
> thanks for checking!

You're welcome, thanks your your work! :)


Pascal

