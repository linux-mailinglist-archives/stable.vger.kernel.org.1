Return-Path: <stable+bounces-95369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E69D8493
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E113E163B63
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD1919F410;
	Mon, 25 Nov 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TeBz95p6"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B39186294;
	Mon, 25 Nov 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534519; cv=none; b=VY28gY3jhYrUM3wnfoRIGdo/wf3vyJYBkxVqVQ3YYGAu51h83sc728+bhBgFMIeEefQE2D4jCeY1JJm9Jn2RVi+pm8rsosmwE+0mVLynlqCBMD2gfd+taAdPeU3oaLnBMVedRdXzlBrTmASSPiQNQToQPhTFEFa3KtDpsiBGshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534519; c=relaxed/simple;
	bh=evyCuPrt3JcpoIWUWgILgOOz042DZOqslNwNTg8rq6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M49IuahYxkcyX0nb59KgilpvFlBrXVnkj+jccaOlqZFFlUw8YIp74YyFLmQWqRpclSUuUmH6E5/fG9elFRrApRVQ3ckemjR7Dp4HR+73vyWxpy8kxFJoSXIsuYw9jHEfyA9uYkCa+Ta58oo1ncYxDQX7T42yONhX/bbxLla2yaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TeBz95p6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XxkCF5Dtgz9sZP;
	Mon, 25 Nov 2024 12:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1732534505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iJeUKBPm/FEIhTBZ51JqJOYigpfXL5/NXhpGKBiNNc=;
	b=TeBz95p6cf7Ct6vYtjTYoNNTt0mFiiExDSGKJQ1D6rkpLEjeZpbqJkUEZzcYDWQb809e7M
	fre9lO4RTINwKTPv1YHNi31zg0tMDZIHgJbOW5883ympi32P/WUtU+qis3haLMXaZTigEk
	9995aOZDR3l/vdFSc5OKxnlenPaT2grlIMyXfiZ7ovPV+rc2x6c+8lXNqfAW/lTC1IbEz7
	EaOtrHJokKEKRErtd30tnfvB/eshZOyQYSu9K1Fo5ioqFoNWVc7pw/Ep54UqOCsLJynt0X
	xDmPm8TCje9fyXLATTsGkcc6M1Mp8WyoqJHHevAUSmgofXYoWuL2LF7WnKqThQ==
Message-ID: <b3a64de3-353c-4214-a876-f44d3f1de07b@mailbox.org>
Date: Mon, 25 Nov 2024 12:35:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH AUTOSEL 6.12 079/107] Revert "drm/amd/display: Block UHBR
 Based On USB-C PD Cable ID"
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20241124133301.3341829-1-sashal@kernel.org>
 <20241124133301.3341829-79-sashal@kernel.org>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20241124133301.3341829-79-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7748cd16edbb6a14f78
X-MBO-RS-META: 49edaesm5ea51jryu1wbphehxgxtgeya

On 2024-11-24 14:29, Sasha Levin wrote:
> From: Ausef Yousof <Ausef.Yousof@amd.com>
> 
> [ Upstream commit d7b86a002cf7e1b55ec311c11264f70d079860b9 ]
> 
> This reverts commit 4f01a68751194d05280d659a65758c09e4af04d6.

Which was patch 16 in this series...


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast

