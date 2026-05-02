Return-Path: <stable+bounces-242576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE7BIzNk9Wk5KwIAu9opvQ
	(envelope-from <stable+bounces-242576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:40:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3664B0B32
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 544B93007BA6
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC9155C97;
	Sat,  2 May 2026 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HrwxLPuc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B4C40DFBE
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777689647; cv=none; b=GsGkjIeQJ5wdUFRPGq/4TbOUr5qVudnopkccNxEnRyl0UhExMvm/mv1DKmp1ZcNFPf19x5kEeh8E+QkhnajJx3lsokPrpOCziWc44bBtBCYrsL0m002RwblnYk3BNO9K1XjT1zudrP0GEgeYj5vBp8Tx8eqX25+Mel+CvI2MYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777689647; c=relaxed/simple;
	bh=FtpVYODButnIwc7tC0qxpxlnZ4cuADQzlvX6aqy6Aww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq9q1Z7B18U4Jqg2Y0NXxDI/duxbplHneG0tx+W/cJESzxb1Q1365/4DGPUxQYNltvOxVFm2NUblQAjrnoeWc+SahqQdAVy5l2JVI9wjqiI1y7S46zXyPMbNttKE2KHUCLUkkLIDb3qJ3/wmHj2Ufo7qjWt6bzUqZmnyL05fUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HrwxLPuc; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dea1272943so1423450a34.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777689645; x=1778294445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxpgPkbG5h5GXRqacb2Du8t+MzFWBe058DRHFOXzC3Q=;
        b=HrwxLPuc5itExXrafm4X0OBCfX+uMevoFzY80O4bpNoAHzrFkcZIXV1smOBrCLuujE
         wpaZrlqwYHyr550v3o78H5794sldoUhmTQ8uqH6JzfHQw3J3FPwn8AuDASwPASTGXmLS
         2LzSddfys3GlXUFtCBSbWQgle0X+LG5Ib3ob2rN4aKmwtQzw8Sol0wFDmybWjAfm5FjE
         P4mmKMfmjK0j5u2pVDxWwbQcKChsXsil9B6X00Fy4Ec6xQMK0LErL2VcyzNJsU11TYlY
         68/Q7RRQvpFAxzNvo/eZtkq+mJ4NlpzJwKLjtqymO3iUyux1AMuyoVd2HnS3kZ3ubZG0
         0v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777689645; x=1778294445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxpgPkbG5h5GXRqacb2Du8t+MzFWBe058DRHFOXzC3Q=;
        b=kjLRHlprLtSNUpSkwbkoPaAAdlNLIIdrwApkPtqBXw8pz5M38wKdjkHismmrBsUc0c
         +mKDe0LsUXURLnJOPogVwnBPd4Zv1P4U8+tc0W4cN7NFgk4DualOanTsvRsXbjkW0TOx
         7yPV9g0M3FRIEr/HZDf4Ht5k76LgSvL7BsiEyYhaSJTC51ORymIbAcEhuOitzXTYu5Gt
         AKwJ+bD7pHosynsxcC2VtE9zXRNs/FEfDhmwQoVfiTmLXWq90p0/85EPkrs6NRmo4/Ie
         Jn/bKpJhpsXl1ys+N2qhtcE5a/phrVUW2+wOFjTcVG6OiSq+qQcb8XFTy8Dwb3f7OduS
         ocTQ==
X-Gm-Message-State: AOJu0Yx6cMb+al7WffPUeAt64PkfVGGya0QsAnlK4xg5mdlcSbY4DLcg
	1ZSN+B++M0M0N9FFB6+FJXq3g6+PBaiDbkFgvR+3vqlxlbP4kI1H0aJ7ADigl+vu9Trq5t+EcZf
	VUxnd
X-Gm-Gg: AeBDievzNEVZQ1hcda71FjJBSOVJNFtj4qNWnhsN9nSW1QqHGyOhCbDBThzKdtfncyk
	vrXWGBBywtV3OEFmavl+8FMRGP1z6Ks0k9Ypwsv2JBl/HyKEIimqJtUUGFIV050fvsBH85faXPS
	5y/FjZJbATPguxtzUDjKNuDxdyNVLT3186PayWpaYcGAge7ure1ITNl7mZtiRao9GRBfuOLQl+w
	5qS5d9MG5z6iMK3WVTTJpPPEas6s7wmWRIAb7gx+Ae2OKDxuLaQYw8HeXMpyOT/8d+oJkEQCDdb
	MvR30lGeVZ2hb55v6kYTe5okZ1YdhwaUDntrI3CZEGpeDRUiKGI++dckTXsM1MvU6Ax1NRHeZq+
	RPBWE9JDFPMOhF9DSG7LOZBjBj70MMVjW8jfy/APvwLoZss3dak85hnKGRdC/QbazOHdCSJKVU1
	ShvaVIynd+AQxByWatoF48mFF6sU3wcBiBsZGTNDCDQfeODPe++/njifc4PjuS/aaFYHD1yiLF4
	56vPWt9LJI8SoFSYQxz
X-Received: by 2002:a05:6820:a0b:b0:696:2b5a:b516 with SMTP id 006d021491bc7-69697e22d92mr741293eaf.41.1777689644900;
        Fri, 01 May 2026 19:40:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69689440f5asm2411273eaf.1.2026.05.01.19.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 19:40:42 -0700 (PDT)
Message-ID: <f32b29e6-c36c-4d10-9ace-ebfca6feaeae@kernel.dk>
Date: Fri, 1 May 2026 20:40:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: ensure EPOLL_ONESHOT is
 propagated for" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, azizcan.d@mileniumsec.com
Cc: stable@vger.kernel.org
References: <2026050100-hamlet-outshoot-27c4@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026050100-hamlet-outshoot-27c4@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1E3664B0B32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242576-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:mid]

On 5/1/26 5:09 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050100-hamlet-outshoot-27c4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Not needed.

-- 
Jens Axboe


